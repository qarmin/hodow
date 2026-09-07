use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si64(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvtsd_si64(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si64(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsd_si64(create__m128d_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si64(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvtsd_si64(create__m128d_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si64(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsd_si64(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si64(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsd_si64(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si64(create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsd_si64(create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si64(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsd_si64(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si64(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsd_si64(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64x() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si64x(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvtsd_si64x(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si64x(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64x_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si64x(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsd_si64x(create__m128d_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si64x(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64x_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si64x(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvtsd_si64x(create__m128d_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si64x(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64x_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si64x(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsd_si64x(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si64x(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64x_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si64x(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsd_si64x(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si64x(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64x_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si64x(create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsd_si64x(create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si64x(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64x_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si64x(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsd_si64x(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si64x(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64x_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si64x(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsd_si64x(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si64x(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si64(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvttsd_si64(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si64(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttsd_si64(create__m128d_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si64(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvttsd_si64(create__m128d_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si64(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttsd_si64(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si64(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttsd_si64(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si64(create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttsd_si64(create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si64(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttsd_si64(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si64(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttsd_si64(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si64(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si64x(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvttsd_si64x(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si64x(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si64x(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttsd_si64x(create__m128d_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si64x(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si64x(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvttsd_si64x(create__m128d_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si64x(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si64x(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttsd_si64x(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si64x(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si64x(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttsd_si64x(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si64x(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si64x(create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttsd_si64x(create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si64x(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si64x(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttsd_si64x(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si64x(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si64x(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttsd_si64x(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si64x(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_stream_si64() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i64; 8]);
        let a = 2i64;
        _mm_stream_si64(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64_si128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtsi64_si128(1i64));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsi64_si128(1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi64_si128(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64x_si128() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtsi64x_si128(1i64));
        check_array_equality(&result, &[1, 0, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtsi64x_si128(1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi64x_si128(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsi128_si64(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvtsi128_si64(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi128_si64(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsi128_si64(create__m128i_from_i32_array([0, -1, 2, -3]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsi128_si64(create__m128i_from_i32_array([0, -1, 2, -3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi128_si64(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsi128_si64(create__m128i_from_i32_array([100, 200, 300, 400]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvtsi128_si64(create__m128i_from_i32_array([100, 200, 300, 400]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi128_si64(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsi128_si64(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvtsi128_si64(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi128_si64(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsi128_si64(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 2147483647).map_err(|e| format!("{e} | call: _mm_cvtsi128_si64(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi128_si64(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsi128_si64(create__m128i_from_i32_array([0, 0, 0, 0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsi128_si64(create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi128_si64(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsi128_si64(create__m128i_from_i32_array([-1, -1, -1, -1]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvtsi128_si64(create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi128_si64(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsi128_si64(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvtsi128_si64(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi128_si64(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64x() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsi128_si64x(create__m128i_from_i32_array([1, 2, 3, 4]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvtsi128_si64x(create__m128i_from_i32_array([1, 2, 3, 4]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi128_si64x(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64x_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsi128_si64x(create__m128i_from_i32_array([0, -1, 2, -3]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsi128_si64x(create__m128i_from_i32_array([0, -1, 2, -3]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi128_si64x(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64x_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsi128_si64x(create__m128i_from_i32_array([100, 200, 300, 400]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvtsi128_si64x(create__m128i_from_i32_array([100, 200, 300, 400]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi128_si64x(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64x_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsi128_si64x(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvtsi128_si64x(create__m128i_from_i32_array([i32::MIN, i32::MIN, i32::MIN, i32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi128_si64x(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64x_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsi128_si64x(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]));
        check_int_equality(result as i32, 2147483647).map_err(|e| format!("{e} | call: _mm_cvtsi128_si64x(create__m128i_from_i32_array([i32::MAX, i32::MAX, i32::MAX, i32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi128_si64x(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64x_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsi128_si64x(create__m128i_from_i32_array([0, 0, 0, 0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsi128_si64x(create__m128i_from_i32_array([0, 0, 0, 0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi128_si64x(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64x_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsi128_si64x(create__m128i_from_i32_array([-1, -1, -1, -1]));
        check_int_equality(result as i32, -1).map_err(|e| format!("{e} | call: _mm_cvtsi128_si64x(create__m128i_from_i32_array([-1, -1, -1, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi128_si64x(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi128_si64x_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsi128_si64x(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvtsi128_si64x(create__m128i_from_i32_array([i32::MIN, i32::MAX, 0, -1]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi128_si64x(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64_sd(create__m128d_from([1.0, 2.0]), 3i64));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| format!("{e} | call: _mm_cvtsi64_sd(create__m128d_from([1.0, 2.0]), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi64_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64_sd(create__m128d_from([0.0f64, -1.0f64]), 1i64));
        check_float_array_equality(&result, &[1.0, -1.0]).map_err(|e| format!("{e} | call: _mm_cvtsi64_sd(create__m128d_from([0.0f64, -1.0f64]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi64_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64_sd(create__m128d_from([100.0f64, 200.0f64]), 1i64));
        check_float_array_equality(&result, &[1.0, 200.0]).map_err(|e| format!("{e} | call: _mm_cvtsi64_sd(create__m128d_from([100.0f64, 200.0f64]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi64_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64_sd(create__m128d_from([f64::MIN, f64::MIN]), 1i64));
        check_float_array_equality(&result, &[1.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cvtsi64_sd(create__m128d_from([f64::MIN, f64::MIN]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi64_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64_sd(create__m128d_from([f64::MAX, f64::MAX]), 1i64));
        check_float_array_equality(&result, &[1.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cvtsi64_sd(create__m128d_from([f64::MAX, f64::MAX]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi64_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64_sd(create__m128d_from([0.0, 0.0]), 1i64));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_cvtsi64_sd(create__m128d_from([0.0, 0.0]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi64_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64_sd(create__m128d_from([f64::NAN, f64::NAN]), 1i64));
        check_float_array_equality(&result, &[1.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cvtsi64_sd(create__m128d_from([f64::NAN, f64::NAN]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi64_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), 1i64));
        check_float_array_equality(&result, &[1.0, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_cvtsi64_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi64_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64x_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64x_sd(create__m128d_from([1.0, 2.0]), 3i64));
        check_float_array_equality(&result, &[3.0, 2.0]).map_err(|e| format!("{e} | call: _mm_cvtsi64x_sd(create__m128d_from([1.0, 2.0]), 3i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi64x_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64x_sd_normal2() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64x_sd(create__m128d_from([0.0f64, -1.0f64]), 1i64));
        check_float_array_equality(&result, &[1.0, -1.0]).map_err(|e| format!("{e} | call: _mm_cvtsi64x_sd(create__m128d_from([0.0f64, -1.0f64]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi64x_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64x_sd_normal3() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64x_sd(create__m128d_from([100.0f64, 200.0f64]), 1i64));
        check_float_array_equality(&result, &[1.0, 200.0]).map_err(|e| format!("{e} | call: _mm_cvtsi64x_sd(create__m128d_from([100.0f64, 200.0f64]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi64x_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64x_sd_boundary_min() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64x_sd(create__m128d_from([f64::MIN, f64::MIN]), 1i64));
        check_float_array_equality(&result, &[1.0, -1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cvtsi64x_sd(create__m128d_from([f64::MIN, f64::MIN]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi64x_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64x_sd_boundary_max() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64x_sd(create__m128d_from([f64::MAX, f64::MAX]), 1i64));
        check_float_array_equality(&result, &[1.0, 1.7976931348623157e308]).map_err(|e| format!("{e} | call: _mm_cvtsi64x_sd(create__m128d_from([f64::MAX, f64::MAX]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi64x_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64x_sd_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64x_sd(create__m128d_from([0.0, 0.0]), 1i64));
        check_float_array_equality(&result, &[1.0, 0.0]).map_err(|e| format!("{e} | call: _mm_cvtsi64x_sd(create__m128d_from([0.0, 0.0]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi64x_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64x_sd_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64x_sd(create__m128d_from([f64::NAN, f64::NAN]), 1i64));
        check_float_array_equality(&result, &[1.0, f64::NAN]).map_err(|e| format!("{e} | call: _mm_cvtsi64x_sd(create__m128d_from([f64::NAN, f64::NAN]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi64x_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse2_mm_cvtsi64x_sd_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64x_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), 1i64));
        check_float_array_equality(&result, &[1.0, -f64::INFINITY]).map_err(|e| format!("{e} | call: _mm_cvtsi64x_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), 1i64)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsi64x_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}
