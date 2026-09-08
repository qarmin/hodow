use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_x86_64_sse_mm_cvtss_si64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_si64(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvtss_si64(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_si64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse_mm_cvtss_si64_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_si64(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtss_si64(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_si64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse_mm_cvtss_si64_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_si64(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvtss_si64(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_si64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse_mm_cvtss_si64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_si64(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtss_si64(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_si64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse_mm_cvtss_si64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_si64(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtss_si64(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_si64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse_mm_cvtss_si64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_si64(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtss_si64(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_si64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse_mm_cvtss_si64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_si64(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtss_si64(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_si64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse_mm_cvtss_si64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_si64(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtss_si64(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_si64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse_mm_cvttss_si64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttss_si64(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvttss_si64(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_si64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse_mm_cvttss_si64_normal2() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttss_si64(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttss_si64(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_si64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse_mm_cvttss_si64_normal3() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttss_si64(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvttss_si64(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_si64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse_mm_cvttss_si64_boundary_min() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttss_si64(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttss_si64(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_si64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse_mm_cvttss_si64_boundary_max() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttss_si64(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttss_si64(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_si64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse_mm_cvttss_si64_boundary_zero() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttss_si64(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttss_si64(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_si64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse_mm_cvttss_si64_boundary_allones() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttss_si64(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttss_si64(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_si64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_64_sse_mm_cvttss_si64_boundary_mixed() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttss_si64(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttss_si64(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_si64(create_random__m128());
            }
        }
    }
    Ok(())
}
