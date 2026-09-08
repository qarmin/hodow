use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsd_si64_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvtsd_si64_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsd_si64_normal2_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64_normal2() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvtsd_si64_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsd_si64_normal3_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64_normal3() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvtsd_si64_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsd_si64_boundary_min_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvtsd_si64_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsd_si64_boundary_max_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvtsd_si64_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsd_si64_boundary_zero_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvtsd_si64_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsd_si64_boundary_allones_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvtsd_si64_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsd_si64_boundary_mixed_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvtsd_si64_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsd_si64x_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64x() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvtsd_si64x_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsd_si64x_normal2_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64x_normal2() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvtsd_si64x_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsd_si64x_normal3_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64x_normal3() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvtsd_si64x_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsd_si64x_boundary_min_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64x_boundary_min() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvtsd_si64x_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsd_si64x_boundary_max_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64x_boundary_max() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvtsd_si64x_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsd_si64x_boundary_zero_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64x_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvtsd_si64x_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsd_si64x_boundary_allones_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64x_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvtsd_si64x_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvtsd_si64x_boundary_mixed_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvtsd_si64x_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvtsd_si64x_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64_normal2_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64_normal2() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64_normal3_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64_normal3() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64_boundary_min_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64_boundary_min() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64_boundary_max_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64_boundary_max() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64_boundary_zero_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64_boundary_allones_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64_boundary_mixed_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64x_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64x_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64x_normal2_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x_normal2() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64x_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64x_normal3_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x_normal3() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64x_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_min_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_min() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64x_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_max_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_max() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64x_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_zero_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64x_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_allones_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64x_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_mixed_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_cvttsd_si64x_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_cvttsd_si64x_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_64_sse2_mm_stream_si64_impl() -> Result<(), String> {
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

pub(super) fn test_x86_64_sse2_mm_stream_si64() -> Result<(), String> {
    unsafe { test_x86_64_sse2_mm_stream_si64_impl() }
}
