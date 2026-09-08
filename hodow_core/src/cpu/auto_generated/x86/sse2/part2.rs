#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comieq_sd_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comieq_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comieq_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comieq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comieq_sd() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comieq_sd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comieq_sd_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comieq_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comieq_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comieq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comieq_sd_normal2() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comieq_sd_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comieq_sd_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comieq_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comieq_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comieq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comieq_sd_normal3() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comieq_sd_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comieq_sd_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comieq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comieq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comieq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comieq_sd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comieq_sd_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comieq_sd_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comieq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comieq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comieq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comieq_sd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comieq_sd_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comieq_sd_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comieq_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comieq_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comieq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comieq_sd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comieq_sd_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comieq_sd_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comieq_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comieq_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comieq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comieq_sd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comieq_sd_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comieq_sd_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comieq_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comieq_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comieq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comieq_sd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comieq_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comieq_sd_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comieq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comieq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comieq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comieq_sd_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comieq_sd_asym_min_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comieq_sd_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comieq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comieq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comieq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comieq_sd_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comieq_sd_asym_max_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comilt_sd_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comilt_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comilt_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comilt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comilt_sd() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comilt_sd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comilt_sd_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comilt_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comilt_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comilt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comilt_sd_normal2() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comilt_sd_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comilt_sd_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comilt_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comilt_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comilt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comilt_sd_normal3() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comilt_sd_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comilt_sd_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comilt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comilt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comilt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comilt_sd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comilt_sd_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comilt_sd_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comilt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comilt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comilt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comilt_sd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comilt_sd_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comilt_sd_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comilt_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comilt_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comilt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comilt_sd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comilt_sd_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comilt_sd_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comilt_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comilt_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comilt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comilt_sd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comilt_sd_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comilt_sd_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comilt_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comilt_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comilt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comilt_sd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comilt_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comilt_sd_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comilt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comilt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comilt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comilt_sd_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comilt_sd_asym_min_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comilt_sd_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comilt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comilt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comilt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comilt_sd_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comilt_sd_asym_max_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comile_sd_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comile_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comile_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comile_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comile_sd() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comile_sd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comile_sd_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comile_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comile_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comile_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comile_sd_normal2() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comile_sd_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comile_sd_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comile_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comile_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comile_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comile_sd_normal3() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comile_sd_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comile_sd_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comile_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comile_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comile_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comile_sd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comile_sd_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comile_sd_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comile_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comile_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comile_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comile_sd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comile_sd_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comile_sd_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comile_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comile_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comile_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comile_sd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comile_sd_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comile_sd_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comile_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comile_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comile_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comile_sd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comile_sd_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comile_sd_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comile_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comile_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comile_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comile_sd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comile_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comile_sd_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comile_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comile_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comile_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comile_sd_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comile_sd_asym_min_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comile_sd_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comile_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comile_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comile_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comile_sd_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comile_sd_asym_max_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comigt_sd_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comigt_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comigt_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comigt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comigt_sd() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comigt_sd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comigt_sd_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comigt_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comigt_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comigt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comigt_sd_normal2() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comigt_sd_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comigt_sd_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comigt_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comigt_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comigt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comigt_sd_normal3() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comigt_sd_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comigt_sd_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comigt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comigt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comigt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comigt_sd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comigt_sd_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comigt_sd_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comigt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comigt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comigt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comigt_sd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comigt_sd_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comigt_sd_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comigt_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comigt_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comigt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comigt_sd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comigt_sd_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comigt_sd_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comigt_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comigt_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comigt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comigt_sd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comigt_sd_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comigt_sd_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comigt_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comigt_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comigt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comigt_sd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comigt_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comigt_sd_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comigt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comigt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comigt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comigt_sd_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comigt_sd_asym_min_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comigt_sd_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comigt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comigt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comigt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comigt_sd_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comigt_sd_asym_max_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comige_sd_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comige_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comige_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comige_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comige_sd() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comige_sd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comige_sd_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comige_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comige_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comige_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comige_sd_normal2() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comige_sd_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comige_sd_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comige_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comige_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comige_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comige_sd_normal3() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comige_sd_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comige_sd_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comige_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comige_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comige_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comige_sd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comige_sd_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comige_sd_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comige_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comige_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comige_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comige_sd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comige_sd_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comige_sd_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comige_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comige_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comige_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comige_sd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comige_sd_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comige_sd_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comige_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comige_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comige_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comige_sd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comige_sd_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comige_sd_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comige_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comige_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comige_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comige_sd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comige_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comige_sd_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comige_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comige_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comige_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comige_sd_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comige_sd_asym_min_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comige_sd_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comige_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comige_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comige_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comige_sd_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comige_sd_asym_max_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comineq_sd_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comineq_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comineq_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comineq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comineq_sd() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comineq_sd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comineq_sd_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comineq_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comineq_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comineq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comineq_sd_normal2() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comineq_sd_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comineq_sd_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comineq_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comineq_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comineq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comineq_sd_normal3() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comineq_sd_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comineq_sd_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comineq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comineq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comineq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comineq_sd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comineq_sd_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comineq_sd_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comineq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comineq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comineq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comineq_sd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comineq_sd_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comineq_sd_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comineq_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comineq_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comineq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comineq_sd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comineq_sd_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comineq_sd_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comineq_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comineq_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comineq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comineq_sd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comineq_sd_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comineq_sd_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comineq_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comineq_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comineq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comineq_sd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comineq_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comineq_sd_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comineq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comineq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comineq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comineq_sd_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comineq_sd_asym_min_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_comineq_sd_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comineq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comineq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comineq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_comineq_sd_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_comineq_sd_asym_max_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomieq_sd_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomieq_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomieq_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomieq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomieq_sd() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomieq_sd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomieq_sd_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomieq_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomieq_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomieq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomieq_sd_normal2() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomieq_sd_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomieq_sd_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomieq_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomieq_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomieq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomieq_sd_normal3() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomieq_sd_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomieq_sd_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomieq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomieq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomieq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomieq_sd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomieq_sd_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomieq_sd_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomieq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomieq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomieq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomieq_sd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomieq_sd_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomieq_sd_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomieq_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomieq_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomieq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomieq_sd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomieq_sd_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomieq_sd_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomieq_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomieq_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomieq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomieq_sd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomieq_sd_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomieq_sd_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomieq_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomieq_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomieq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomieq_sd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomieq_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomieq_sd_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomieq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomieq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomieq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomieq_sd_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomieq_sd_asym_min_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomieq_sd_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomieq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomieq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomieq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomieq_sd_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomieq_sd_asym_max_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomilt_sd_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomilt_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomilt_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomilt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomilt_sd() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomilt_sd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomilt_sd_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomilt_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomilt_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomilt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomilt_sd_normal2() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomilt_sd_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomilt_sd_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomilt_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomilt_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomilt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomilt_sd_normal3() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomilt_sd_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomilt_sd_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomilt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomilt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomilt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomilt_sd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomilt_sd_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomilt_sd_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomilt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomilt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomilt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomilt_sd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomilt_sd_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomilt_sd_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomilt_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomilt_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomilt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomilt_sd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomilt_sd_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomilt_sd_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomilt_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomilt_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomilt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomilt_sd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomilt_sd_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomilt_sd_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomilt_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomilt_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomilt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomilt_sd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomilt_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomilt_sd_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomilt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomilt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomilt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomilt_sd_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomilt_sd_asym_min_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomilt_sd_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomilt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomilt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomilt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomilt_sd_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomilt_sd_asym_max_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomile_sd_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomile_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomile_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomile_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomile_sd() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomile_sd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomile_sd_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomile_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomile_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomile_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomile_sd_normal2() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomile_sd_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomile_sd_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomile_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomile_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomile_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomile_sd_normal3() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomile_sd_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomile_sd_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomile_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomile_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomile_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomile_sd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomile_sd_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomile_sd_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomile_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomile_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomile_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomile_sd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomile_sd_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomile_sd_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomile_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomile_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomile_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomile_sd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomile_sd_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomile_sd_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomile_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomile_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomile_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomile_sd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomile_sd_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomile_sd_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomile_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomile_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomile_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomile_sd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomile_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomile_sd_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomile_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomile_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomile_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomile_sd_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomile_sd_asym_min_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomile_sd_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomile_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomile_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomile_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomile_sd_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomile_sd_asym_max_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomigt_sd_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomigt_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomigt_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomigt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomigt_sd() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomigt_sd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomigt_sd_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomigt_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomigt_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomigt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomigt_sd_normal2() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomigt_sd_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomigt_sd_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomigt_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomigt_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomigt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomigt_sd_normal3() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomigt_sd_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomigt_sd_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomigt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomigt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomigt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomigt_sd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomigt_sd_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomigt_sd_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomigt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomigt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomigt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomigt_sd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomigt_sd_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomigt_sd_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomigt_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomigt_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomigt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomigt_sd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomigt_sd_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomigt_sd_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomigt_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomigt_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomigt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomigt_sd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomigt_sd_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomigt_sd_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomigt_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomigt_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomigt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomigt_sd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomigt_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomigt_sd_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomigt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomigt_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomigt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomigt_sd_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomigt_sd_asym_min_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomigt_sd_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomigt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomigt_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomigt_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomigt_sd_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomigt_sd_asym_max_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomige_sd_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomige_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomige_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomige_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomige_sd() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomige_sd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomige_sd_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomige_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomige_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomige_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomige_sd_normal2() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomige_sd_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomige_sd_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomige_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomige_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomige_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomige_sd_normal3() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomige_sd_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomige_sd_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomige_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomige_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomige_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomige_sd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomige_sd_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomige_sd_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomige_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomige_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomige_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomige_sd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomige_sd_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomige_sd_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomige_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomige_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomige_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomige_sd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomige_sd_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomige_sd_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomige_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomige_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomige_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomige_sd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomige_sd_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomige_sd_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomige_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomige_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomige_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomige_sd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomige_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomige_sd_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomige_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomige_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomige_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomige_sd_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomige_sd_asym_min_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomige_sd_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomige_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomige_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomige_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomige_sd_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomige_sd_asym_max_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomineq_sd_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomineq_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomineq_sd(create__m128d_from([1.0, 2.0]), create__m128d_from([3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomineq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomineq_sd() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomineq_sd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomineq_sd_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomineq_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomineq_sd(create__m128d_from([0.0f64, -1.0f64]), create__m128d_from([10.0f64, 9.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomineq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomineq_sd_normal2() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomineq_sd_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomineq_sd_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomineq_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomineq_sd(create__m128d_from([100.0f64, 200.0f64]), create__m128d_from([110.0f64, 210.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomineq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomineq_sd_normal3() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomineq_sd_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomineq_sd_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomineq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomineq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomineq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomineq_sd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomineq_sd_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomineq_sd_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomineq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomineq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomineq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomineq_sd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomineq_sd_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomineq_sd_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomineq_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomineq_sd(create__m128d_from([0.0, 0.0]), create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomineq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomineq_sd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomineq_sd_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomineq_sd_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomineq_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomineq_sd(create__m128d_from([f64::NAN, f64::NAN]), create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomineq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomineq_sd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomineq_sd_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomineq_sd_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomineq_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomineq_sd(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]), create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomineq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomineq_sd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomineq_sd_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomineq_sd_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomineq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomineq_sd(create__m128d_from([f64::MIN, f64::MIN]), create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomineq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomineq_sd_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomineq_sd_asym_min_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_ucomineq_sd_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomineq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomineq_sd(create__m128d_from([f64::MAX, f64::MAX]), create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomineq_sd(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_ucomineq_sd_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_ucomineq_sd_asym_max_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvtpd_epi32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtpd_epi32(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvtpd_epi32(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtpd_epi32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvtpd_epi32() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvtpd_epi32_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvtsd_si32_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si32(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvtsd_si32(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvtsd_si32() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvtsd_si32_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvtsd_si32_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si32(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsd_si32(create__m128d_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvtsd_si32_normal2() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvtsd_si32_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvtsd_si32_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si32(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvtsd_si32(create__m128d_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvtsd_si32_normal3() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvtsd_si32_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvtsd_si32_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si32(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvtsd_si32(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvtsd_si32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvtsd_si32_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvtsd_si32_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si32(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvtsd_si32(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvtsd_si32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvtsd_si32_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvtsd_si32_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si32(create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtsd_si32(create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvtsd_si32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvtsd_si32_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvtsd_si32_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si32(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvtsd_si32(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvtsd_si32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvtsd_si32_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvtsd_si32_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtsd_si32(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvtsd_si32(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_si32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvtsd_si32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvtsd_si32_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvtsd_ss_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtsd_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128d_from([5.0, 6.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_cvtsd_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128d_from([5.0, 6.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_ss(create_random__m128(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvtsd_ss() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvtsd_ss_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvtsd_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtsd_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_cvtsd_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_ss(create_random__m128(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvtsd_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvtsd_ss_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvtsd_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtsd_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_cvtsd_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_ss(create_random__m128(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvtsd_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvtsd_ss_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvtsd_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtsd_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cvtsd_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_ss(create_random__m128(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvtsd_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvtsd_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvtsd_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtsd_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cvtsd_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_ss(create_random__m128(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvtsd_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvtsd_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvtsd_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtsd_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_cvtsd_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_ss(create_random__m128(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvtsd_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvtsd_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvtsd_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtsd_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cvtsd_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_ss(create_random__m128(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvtsd_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvtsd_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvtsd_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtsd_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128d_from([1.0, 2.0])));
        check_float_array_equality(&result, &[1.0, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_cvtsd_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtsd_ss(create_random__m128(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvtsd_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvtsd_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvttpd_epi32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvttpd_epi32(create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[1, 2, 0, 0]).map_err(|e| format!("{e} | call: _mm_cvttpd_epi32(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttpd_epi32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvttpd_epi32() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvttpd_epi32_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvttsd_si32_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si32(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvttsd_si32(create__m128d_from([1.0, 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvttsd_si32() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvttsd_si32_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvttsd_si32_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si32(create__m128d_from([0.0f64, -1.0f64]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttsd_si32(create__m128d_from([0.0f64, -1.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvttsd_si32_normal2() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvttsd_si32_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvttsd_si32_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si32(create__m128d_from([100.0f64, 200.0f64]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvttsd_si32(create__m128d_from([100.0f64, 200.0f64]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvttsd_si32_normal3() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvttsd_si32_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvttsd_si32_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si32(create__m128d_from([f64::MIN, f64::MIN]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvttsd_si32(create__m128d_from([f64::MIN, f64::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvttsd_si32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvttsd_si32_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvttsd_si32_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si32(create__m128d_from([f64::MAX, f64::MAX]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvttsd_si32(create__m128d_from([f64::MAX, f64::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvttsd_si32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvttsd_si32_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvttsd_si32_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si32(create__m128d_from([0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttsd_si32(create__m128d_from([0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvttsd_si32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvttsd_si32_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvttsd_si32_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si32(create__m128d_from([f64::NAN, f64::NAN]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvttsd_si32(create__m128d_from([f64::NAN, f64::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvttsd_si32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvttsd_si32_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvttsd_si32_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsd_si32(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvttsd_si32(create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttsd_si32(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvttsd_si32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvttsd_si32_boundary_mixed_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_cvttps_epi32_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvttps_epi32(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[1, 2, 3, 4]).map_err(|e| format!("{e} | call: _mm_cvttps_epi32(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttps_epi32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_cvttps_epi32() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_cvttps_epi32_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_stream_pd_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([2.0, 3.0]);
        _mm_stream_pd(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_stream_pd() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_stream_pd_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_stream_pd_normal2_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([0.0f64, -1.0f64]);
        _mm_stream_pd(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_stream_pd_normal2() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_stream_pd_normal2_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_stream_pd_normal3_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([100.0f64, 200.0f64]);
        _mm_stream_pd(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_stream_pd_normal3() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_stream_pd_normal3_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_stream_pd_boundary_min_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::MIN, f64::MIN]);
        _mm_stream_pd(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_stream_pd_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_stream_pd_boundary_min_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_stream_pd_boundary_max_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::MAX, f64::MAX]);
        _mm_stream_pd(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_stream_pd_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_stream_pd_boundary_max_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_stream_pd_boundary_zero_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([0.0, 0.0]);
        _mm_stream_pd(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_stream_pd_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_stream_pd_boundary_zero_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_stream_pd_boundary_allones_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::NAN, f64::NAN]);
        _mm_stream_pd(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_stream_pd_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_stream_pd_boundary_allones_impl() }
}

#[target_feature(enable = "sse2")]
fn test_x86_sse2_mm_stream_pd_boundary_mixed_impl() -> Result<(), String> {
        if cfg!(miri) {
            return Ok(());
        }
    unsafe {
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1.0f64; 8]);
        let a = create__m128d_from([f64::INFINITY, f64::NEG_INFINITY]);
        _mm_stream_pd(ptr_mem_addr.0.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_x86_sse2_mm_stream_pd_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse2_mm_stream_pd_boundary_mixed_impl() }
}
