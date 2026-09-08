#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_sqrt_ss_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_sqrt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_sqrt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_sqrt_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_sqrt_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_sqrt_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_sqrt_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_sqrt_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_sqrt_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_sqrt_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_sqrt_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_sqrt_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_float_array_equality(&result, &[10.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_sqrt_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_sqrt_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_sqrt_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_sqrt_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_sqrt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_sqrt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_sqrt_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_sqrt_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_sqrt_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_sqrt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[1.8446743e19, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_sqrt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_sqrt_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_sqrt_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_sqrt_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_sqrt_ss(create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_sqrt_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_sqrt_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_sqrt_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_sqrt_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_sqrt_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_sqrt_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_sqrt_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_sqrt_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_sqrt_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_sqrt_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_sqrt_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_sqrt_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_sqrt_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_sqrt_ps_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_sqrt_ps(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[1.0, 1.4142135, 1.7320508, 2.0]).map_err(|e| format!("{e} | call: _mm_sqrt_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_sqrt_ps() -> Result<(), String> {
    unsafe { test_x86_sse_mm_sqrt_ps_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_sqrt_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_sqrt_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_float_array_equality(&result, &[0.0, f32::NAN, 1.4142135, f32::NAN]).map_err(|e| format!("{e} | call: _mm_sqrt_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_sqrt_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_sqrt_ps_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_sqrt_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_sqrt_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_float_array_equality(&result, &[10.0, 14.142136, 17.320509, 20.0]).map_err(|e| format!("{e} | call: _mm_sqrt_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_sqrt_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_sqrt_ps_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_sqrt_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_sqrt_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_sqrt_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_sqrt_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_sqrt_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_sqrt_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_sqrt_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[1.8446743e19, 1.8446743e19, 1.8446743e19, 1.8446743e19]).map_err(|e| format!("{e} | call: _mm_sqrt_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_sqrt_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_sqrt_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_sqrt_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_sqrt_ps(create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_sqrt_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_sqrt_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_sqrt_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_sqrt_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_sqrt_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_sqrt_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_sqrt_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_sqrt_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_sqrt_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_sqrt_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::NAN, -0.0, 7.666467e-20]).map_err(|e| format!("{e} | call: _mm_sqrt_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_sqrt_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_sqrt_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_sqrt_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rcp_ss_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rcp_ss(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[0.99975586, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_rcp_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rcp_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rcp_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rcp_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rcp_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rcp_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_float_array_equality(&result, &[f32::INFINITY, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_rcp_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rcp_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rcp_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rcp_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rcp_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rcp_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_float_array_equality(&result, &[0.0099983215, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_rcp_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rcp_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rcp_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rcp_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rcp_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rcp_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-0.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_rcp_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rcp_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rcp_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rcp_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rcp_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rcp_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_rcp_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rcp_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rcp_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rcp_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rcp_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rcp_ss(create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_rcp_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rcp_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rcp_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rcp_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rcp_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rcp_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_rcp_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rcp_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rcp_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rcp_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rcp_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rcp_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_rcp_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rcp_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rcp_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rcp_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rcp_ps_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rcp_ps(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[0.99975586, 0.49987793, 0.333313, 0.24993896]).map_err(|e| format!("{e} | call: _mm_rcp_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rcp_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rcp_ps() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rcp_ps_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rcp_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rcp_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_float_array_equality(&result, &[f32::INFINITY, -0.99975586, 0.49987793, -0.333313]).map_err(|e| format!("{e} | call: _mm_rcp_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rcp_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rcp_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rcp_ps_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rcp_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rcp_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_float_array_equality(&result, &[0.0099983215, 0.0049991608, 0.0033330917, 0.0024995804]).map_err(|e| format!("{e} | call: _mm_rcp_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rcp_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rcp_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rcp_ps_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rcp_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rcp_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_rcp_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rcp_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rcp_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rcp_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rcp_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rcp_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_rcp_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rcp_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rcp_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rcp_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rcp_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rcp_ps(create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_rcp_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rcp_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rcp_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rcp_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rcp_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rcp_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_rcp_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rcp_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rcp_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rcp_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rcp_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rcp_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0, -0.0, -f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_rcp_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rcp_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rcp_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rcp_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ss_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[0.9998779, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_rsqrt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rsqrt_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rsqrt_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rsqrt_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_float_array_equality(&result, &[f32::INFINITY, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_rsqrt_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rsqrt_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rsqrt_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rsqrt_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_float_array_equality(&result, &[0.099990845, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_rsqrt_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rsqrt_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rsqrt_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rsqrt_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_rsqrt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rsqrt_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rsqrt_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rsqrt_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[5.421011e-20, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_rsqrt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rsqrt_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rsqrt_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rsqrt_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ss(create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f32::INFINITY, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_rsqrt_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rsqrt_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rsqrt_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rsqrt_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_rsqrt_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rsqrt_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rsqrt_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rsqrt_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_rsqrt_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rsqrt_ss(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rsqrt_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rsqrt_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ps_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ps(create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_float_array_equality(&result, &[0.9998779, 0.70703125, 0.5772705, 0.49993896]).map_err(|e| format!("{e} | call: _mm_rsqrt_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rsqrt_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rsqrt_ps() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rsqrt_ps_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::NAN, 0.70703125, f32::NAN]).map_err(|e| format!("{e} | call: _mm_rsqrt_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rsqrt_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rsqrt_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rsqrt_ps_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32])));
        check_float_array_equality(&result, &[0.099990845, 0.07070923, 0.05773163, 0.049995422]).map_err(|e| format!("{e} | call: _mm_rsqrt_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rsqrt_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rsqrt_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rsqrt_ps_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_rsqrt_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rsqrt_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rsqrt_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rsqrt_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_rsqrt_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rsqrt_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rsqrt_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rsqrt_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ps(create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f32::INFINITY, f32::INFINITY, f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_rsqrt_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rsqrt_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rsqrt_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rsqrt_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_rsqrt_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rsqrt_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rsqrt_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rsqrt_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_rsqrt_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_rsqrt_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0, f32::NAN, -f32::INFINITY, f32::INFINITY]).map_err(|e| format!("{e} | call: _mm_rsqrt_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_rsqrt_ps(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_rsqrt_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_rsqrt_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_min_ss_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_min_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_min_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_min_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_min_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_min_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_min_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_min_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_min_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_min_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_min_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_min_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_min_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_min_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_min_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_min_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_min_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_min_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_min_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_min_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_min_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_min_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_min_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_min_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_min_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_min_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_min_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_min_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_min_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_min_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_min_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_min_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_min_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_min_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_min_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_min_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_min_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_min_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_min_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_min_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_min_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_min_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_min_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_min_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_min_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_min_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_min_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_min_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_min_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_min_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_min_ps_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_min_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[1.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_min_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_min_ps() -> Result<(), String> {
    unsafe { test_x86_sse_mm_min_ps_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_min_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_min_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_min_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_min_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_min_ps_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_min_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_min_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[100.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_min_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_min_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_min_ps_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_min_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_min_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_min_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_min_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_min_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_min_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_min_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_min_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_min_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_min_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_min_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_min_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_min_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_min_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_min_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_min_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_min_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_min_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_min_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_min_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_min_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_min_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_min_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_min_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_min_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_min_ps_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_min_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_min_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_min_ps_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_min_ps_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_min_ps_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_min_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_min_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_min_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_min_ps_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_min_ps_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_max_ss_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_max_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_max_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_max_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_max_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_max_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_max_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[10.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_max_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_max_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_max_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_max_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_max_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[110.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_max_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_max_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_max_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_max_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_max_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_max_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_max_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_max_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_max_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_max_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_max_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_max_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_max_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_max_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_max_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_max_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_max_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_max_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_max_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_max_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_max_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_max_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_max_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_max_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_max_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_max_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_max_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_max_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_max_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_max_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_max_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_max_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_max_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_max_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_max_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_max_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_max_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_max_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_max_ps_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_max_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[5.0, 6.0, 7.0, 8.0]).map_err(|e| format!("{e} | call: _mm_max_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_max_ps() -> Result<(), String> {
    unsafe { test_x86_sse_mm_max_ps_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_max_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_max_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[10.0, 9.0, 12.0, 7.0]).map_err(|e| format!("{e} | call: _mm_max_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_max_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_max_ps_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_max_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_max_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[110.0, 210.0, 310.0, 410.0]).map_err(|e| format!("{e} | call: _mm_max_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_max_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_max_ps_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_max_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_max_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[-3.4028235e38, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_max_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_max_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_max_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_max_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_max_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_max_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_max_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_max_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_max_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_max_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_max_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_max_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_max_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_max_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_max_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_max_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_max_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_max_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_max_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_max_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::INFINITY, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_max_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_max_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_max_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_max_ps_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_max_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_max_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_max_ps_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_max_ps_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_max_ps_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_max_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[3.4028235e38, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_max_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_max_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_max_ps_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_max_ps_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpeq_ss_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpeq_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_cmpeq_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpeq_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpeq_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpeq_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpeq_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_cmpeq_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpeq_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpeq_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpeq_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpeq_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[0.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_cmpeq_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpeq_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpeq_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpeq_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpeq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpeq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpeq_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpeq_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpeq_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpeq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpeq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpeq_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpeq_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpeq_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpeq_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_cmpeq_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpeq_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpeq_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpeq_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpeq_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[0.0, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpeq_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpeq_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpeq_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpeq_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpeq_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_cmpeq_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpeq_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpeq_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpeq_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpeq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpeq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpeq_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpeq_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpeq_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpeq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpeq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpeq_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpeq_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmplt_ss_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmplt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[f32::NAN, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_cmplt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmplt_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmplt_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmplt_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmplt_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[f32::NAN, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_cmplt_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmplt_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmplt_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmplt_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmplt_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[f32::NAN, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_cmplt_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmplt_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmplt_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmplt_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmplt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmplt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmplt_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmplt_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmplt_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmplt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmplt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmplt_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmplt_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmplt_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmplt_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmplt_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmplt_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmplt_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmplt_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmplt_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[0.0, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmplt_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmplt_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmplt_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmplt_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmplt_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_cmplt_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmplt_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmplt_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmplt_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmplt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmplt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmplt_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmplt_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmplt_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmplt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmplt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmplt_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmplt_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmple_ss_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmple_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[f32::NAN, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_cmple_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmple_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmple_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmple_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmple_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[f32::NAN, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_cmple_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmple_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmple_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmple_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmple_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[f32::NAN, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_cmple_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmple_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmple_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmple_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmple_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmple_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmple_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmple_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmple_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmple_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmple_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmple_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmple_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmple_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmple_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_cmple_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmple_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmple_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmple_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmple_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[0.0, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmple_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmple_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmple_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmple_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmple_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_cmple_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmple_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmple_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmple_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmple_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmple_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmple_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmple_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmple_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmple_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmple_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmple_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmple_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpgt_ss_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpgt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_cmpgt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpgt_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpgt_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpgt_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpgt_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_cmpgt_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpgt_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpgt_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpgt_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpgt_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[0.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_cmpgt_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpgt_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpgt_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpgt_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpgt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpgt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpgt_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpgt_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpgt_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpgt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpgt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpgt_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpgt_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpgt_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpgt_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpgt_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpgt_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpgt_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpgt_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpgt_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[0.0, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpgt_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpgt_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpgt_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpgt_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpgt_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_cmpgt_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpgt_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpgt_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpgt_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpgt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpgt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpgt_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpgt_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpgt_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpgt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpgt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpgt_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpgt_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpge_ss_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpge_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_cmpge_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpge_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpge_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpge_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpge_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_cmpge_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpge_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpge_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpge_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpge_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[0.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_cmpge_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpge_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpge_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpge_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpge_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpge_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpge_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpge_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpge_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpge_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpge_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpge_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpge_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpge_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpge_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_cmpge_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpge_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpge_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpge_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpge_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[0.0, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpge_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpge_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpge_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpge_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpge_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_cmpge_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpge_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpge_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpge_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpge_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpge_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpge_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpge_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpge_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpge_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpge_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpge_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpge_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpneq_ss_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpneq_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[f32::NAN, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_cmpneq_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpneq_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpneq_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpneq_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpneq_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[f32::NAN, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_cmpneq_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpneq_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpneq_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpneq_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpneq_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[f32::NAN, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_cmpneq_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpneq_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpneq_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpneq_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpneq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpneq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpneq_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpneq_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpneq_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpneq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpneq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpneq_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpneq_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpneq_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpneq_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpneq_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpneq_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpneq_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpneq_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpneq_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpneq_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpneq_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpneq_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpneq_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpneq_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_cmpneq_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpneq_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpneq_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpneq_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpneq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpneq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpneq_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpneq_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpneq_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpneq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpneq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpneq_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpneq_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnlt_ss_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnlt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_cmpnlt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnlt_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnlt_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnlt_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnlt_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_cmpnlt_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnlt_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnlt_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnlt_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnlt_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[0.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_cmpnlt_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnlt_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnlt_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnlt_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnlt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpnlt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnlt_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnlt_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnlt_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnlt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpnlt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnlt_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnlt_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnlt_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnlt_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_cmpnlt_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnlt_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnlt_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnlt_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnlt_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnlt_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnlt_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnlt_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnlt_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnlt_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_cmpnlt_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnlt_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnlt_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnlt_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnlt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpnlt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnlt_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnlt_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnlt_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnlt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpnlt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnlt_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnlt_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnle_ss_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnle_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_cmpnle_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnle_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnle_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnle_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnle_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_cmpnle_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnle_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnle_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnle_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnle_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[0.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_cmpnle_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnle_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnle_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnle_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnle_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpnle_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnle_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnle_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnle_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnle_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpnle_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnle_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnle_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnle_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnle_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpnle_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnle_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnle_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnle_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnle_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnle_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnle_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnle_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnle_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnle_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_cmpnle_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnle_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnle_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnle_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnle_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpnle_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnle_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnle_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnle_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnle_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpnle_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnle_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnle_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpngt_ss_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpngt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[f32::NAN, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_cmpngt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpngt_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpngt_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpngt_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpngt_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[f32::NAN, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_cmpngt_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpngt_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpngt_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpngt_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpngt_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[f32::NAN, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_cmpngt_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpngt_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpngt_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpngt_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpngt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpngt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpngt_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpngt_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpngt_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpngt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpngt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpngt_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpngt_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpngt_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpngt_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_cmpngt_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpngt_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpngt_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpngt_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpngt_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpngt_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpngt_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpngt_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpngt_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpngt_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_cmpngt_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpngt_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpngt_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpngt_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpngt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpngt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpngt_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpngt_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpngt_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpngt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpngt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpngt_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpngt_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnge_ss_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnge_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[f32::NAN, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_cmpnge_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnge_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnge_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnge_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnge_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[f32::NAN, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_cmpnge_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnge_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnge_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnge_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnge_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[f32::NAN, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_cmpnge_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnge_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnge_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnge_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnge_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpnge_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnge_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnge_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnge_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnge_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpnge_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnge_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnge_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnge_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnge_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpnge_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnge_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnge_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnge_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnge_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnge_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnge_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnge_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnge_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnge_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_cmpnge_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnge_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnge_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnge_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnge_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpnge_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnge_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnge_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnge_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnge_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpnge_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnge_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnge_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpord_ss_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpord_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[f32::NAN, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_cmpord_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpord_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpord_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpord_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpord_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[f32::NAN, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_cmpord_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpord_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpord_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpord_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpord_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[f32::NAN, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_cmpord_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpord_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpord_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpord_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpord_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpord_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpord_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpord_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpord_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpord_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpord_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpord_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpord_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpord_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpord_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f32::NAN, 0.0, 0.0, 0.0]).map_err(|e| format!("{e} | call: _mm_cmpord_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpord_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpord_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpord_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpord_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[0.0, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpord_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpord_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpord_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpord_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpord_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_cmpord_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpord_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpord_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpord_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpord_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpord_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpord_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpord_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpord_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpord_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpord_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpord_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpord_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpunord_ss_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpunord_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0, 2.0, 3.0, 4.0]).map_err(|e| format!("{e} | call: _mm_cmpunord_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpunord_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpunord_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpunord_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpunord_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[0.0, -1.0, 2.0, -3.0]).map_err(|e| format!("{e} | call: _mm_cmpunord_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpunord_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpunord_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpunord_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpunord_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[0.0, 200.0, 300.0, 400.0]).map_err(|e| format!("{e} | call: _mm_cmpunord_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpunord_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpunord_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpunord_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpunord_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpunord_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpunord_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpunord_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpunord_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpunord_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpunord_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpunord_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpunord_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpunord_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpunord_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpunord_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpunord_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpunord_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpunord_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpunord_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpunord_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpunord_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpunord_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpunord_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpunord_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0, -f32::INFINITY, -0.0, 5.877472e-39]).map_err(|e| format!("{e} | call: _mm_cmpunord_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpunord_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpunord_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpunord_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpunord_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0, -3.4028235e38, -3.4028235e38, -3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpunord_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpunord_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpunord_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpunord_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpunord_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0, 3.4028235e38, 3.4028235e38, 3.4028235e38]).map_err(|e| format!("{e} | call: _mm_cmpunord_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpunord_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpunord_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpeq_ps_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpeq_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpeq_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpeq_ps() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpeq_ps_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpeq_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpeq_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpeq_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpeq_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpeq_ps_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpeq_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpeq_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpeq_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpeq_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpeq_ps_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpeq_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpeq_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpeq_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpeq_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpeq_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpeq_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpeq_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpeq_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpeq_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpeq_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpeq_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpeq_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpeq_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpeq_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpeq_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpeq_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpeq_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpeq_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpeq_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpeq_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpeq_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpeq_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpeq_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpeq_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpeq_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpeq_ps_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpeq_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpeq_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpeq_ps_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpeq_ps_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpeq_ps_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpeq_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpeq_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpeq_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpeq_ps_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpeq_ps_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmplt_ps_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmplt_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmplt_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmplt_ps() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmplt_ps_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmplt_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmplt_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmplt_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmplt_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmplt_ps_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmplt_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmplt_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmplt_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmplt_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmplt_ps_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmplt_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmplt_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmplt_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmplt_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmplt_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmplt_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmplt_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmplt_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmplt_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmplt_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmplt_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmplt_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmplt_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmplt_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmplt_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmplt_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmplt_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmplt_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmplt_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmplt_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmplt_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmplt_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmplt_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmplt_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmplt_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmplt_ps_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmplt_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmplt_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmplt_ps_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmplt_ps_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmplt_ps_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmplt_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmplt_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmplt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmplt_ps_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmplt_ps_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmple_ps_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmple_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmple_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmple_ps() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmple_ps_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmple_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmple_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmple_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmple_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmple_ps_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmple_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmple_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmple_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmple_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmple_ps_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmple_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmple_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmple_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmple_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmple_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmple_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmple_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmple_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmple_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmple_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmple_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmple_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmple_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmple_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmple_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmple_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmple_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmple_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmple_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmple_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmple_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmple_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmple_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmple_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmple_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmple_ps_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmple_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmple_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmple_ps_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmple_ps_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmple_ps_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmple_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmple_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmple_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmple_ps_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmple_ps_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpgt_ps_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpgt_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpgt_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpgt_ps() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpgt_ps_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpgt_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpgt_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpgt_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpgt_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpgt_ps_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpgt_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpgt_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpgt_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpgt_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpgt_ps_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpgt_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpgt_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpgt_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpgt_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpgt_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpgt_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpgt_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpgt_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpgt_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpgt_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpgt_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpgt_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpgt_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpgt_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpgt_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpgt_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpgt_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpgt_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpgt_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpgt_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpgt_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpgt_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpgt_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpgt_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpgt_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpgt_ps_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpgt_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpgt_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpgt_ps_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpgt_ps_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpgt_ps_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpgt_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpgt_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpgt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpgt_ps_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpgt_ps_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpge_ps_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpge_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpge_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpge_ps() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpge_ps_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpge_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpge_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpge_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpge_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpge_ps_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpge_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpge_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpge_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpge_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpge_ps_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpge_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpge_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpge_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpge_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpge_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpge_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpge_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpge_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpge_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpge_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpge_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpge_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpge_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpge_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpge_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpge_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpge_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpge_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpge_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpge_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpge_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpge_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpge_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpge_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpge_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpge_ps_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpge_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpge_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpge_ps_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpge_ps_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpge_ps_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpge_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpge_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpge_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpge_ps_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpge_ps_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpneq_ps_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpneq_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpneq_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpneq_ps() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpneq_ps_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpneq_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpneq_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpneq_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpneq_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpneq_ps_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpneq_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpneq_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpneq_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpneq_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpneq_ps_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpneq_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpneq_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpneq_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpneq_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpneq_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpneq_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpneq_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpneq_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpneq_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpneq_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpneq_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpneq_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpneq_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpneq_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpneq_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpneq_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpneq_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpneq_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpneq_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpneq_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpneq_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpneq_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpneq_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpneq_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpneq_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpneq_ps_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpneq_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpneq_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpneq_ps_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpneq_ps_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpneq_ps_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpneq_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpneq_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpneq_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpneq_ps_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpneq_ps_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnlt_ps_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnlt_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpnlt_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnlt_ps() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnlt_ps_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnlt_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnlt_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpnlt_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnlt_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnlt_ps_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnlt_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnlt_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpnlt_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnlt_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnlt_ps_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnlt_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnlt_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnlt_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnlt_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnlt_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnlt_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnlt_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnlt_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnlt_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnlt_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnlt_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnlt_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnlt_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnlt_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnlt_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnlt_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnlt_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnlt_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnlt_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnlt_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnlt_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnlt_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnlt_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnlt_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnlt_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnlt_ps_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnlt_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpnlt_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnlt_ps_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnlt_ps_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnlt_ps_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnlt_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnlt_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnlt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnlt_ps_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnlt_ps_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnle_ps_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnle_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpnle_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnle_ps() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnle_ps_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnle_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnle_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpnle_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnle_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnle_ps_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnle_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnle_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpnle_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnle_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnle_ps_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnle_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnle_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpnle_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnle_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnle_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnle_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnle_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpnle_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnle_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnle_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnle_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnle_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpnle_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnle_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnle_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnle_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnle_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnle_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnle_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnle_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnle_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnle_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpnle_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnle_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnle_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnle_ps_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnle_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpnle_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnle_ps_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnle_ps_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnle_ps_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnle_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnle_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnle_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnle_ps_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnle_ps_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpngt_ps_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpngt_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpngt_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpngt_ps() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpngt_ps_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpngt_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpngt_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpngt_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpngt_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpngt_ps_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpngt_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpngt_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpngt_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpngt_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpngt_ps_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpngt_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpngt_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpngt_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpngt_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpngt_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpngt_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpngt_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpngt_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpngt_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpngt_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpngt_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpngt_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpngt_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpngt_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpngt_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpngt_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpngt_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpngt_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpngt_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpngt_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpngt_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpngt_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpngt_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpngt_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpngt_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpngt_ps_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpngt_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpngt_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpngt_ps_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpngt_ps_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpngt_ps_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpngt_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpngt_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpngt_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpngt_ps_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpngt_ps_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnge_ps_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnge_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnge_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnge_ps() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnge_ps_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnge_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnge_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnge_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnge_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnge_ps_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnge_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnge_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnge_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnge_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnge_ps_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnge_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnge_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpnge_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnge_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnge_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnge_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnge_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpnge_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnge_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnge_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnge_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnge_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpnge_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnge_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnge_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnge_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnge_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnge_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnge_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnge_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnge_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnge_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpnge_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnge_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnge_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnge_ps_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnge_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpnge_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnge_ps_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnge_ps_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpnge_ps_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpnge_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpnge_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpnge_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpnge_ps_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpnge_ps_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpord_ps_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpord_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpord_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpord_ps() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpord_ps_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpord_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpord_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpord_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpord_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpord_ps_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpord_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpord_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpord_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpord_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpord_ps_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpord_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpord_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpord_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpord_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpord_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpord_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpord_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpord_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpord_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpord_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpord_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpord_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpord_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpord_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpord_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpord_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpord_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpord_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpord_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpord_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpord_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpord_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpord_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpord_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpord_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpord_ps_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpord_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpord_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpord_ps_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpord_ps_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpord_ps_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpord_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpord_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpord_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpord_ps_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpord_ps_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpunord_ps_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpunord_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpunord_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpunord_ps() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpunord_ps_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpunord_ps_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpunord_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpunord_ps(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpunord_ps_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpunord_ps_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpunord_ps_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpunord_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpunord_ps(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpunord_ps_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpunord_ps_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpunord_ps_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpunord_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpunord_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpunord_ps_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpunord_ps_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpunord_ps_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpunord_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpunord_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpunord_ps_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpunord_ps_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpunord_ps_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpunord_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpunord_ps(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpunord_ps_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpunord_ps_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpunord_ps_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpunord_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN])));
        check_float_array_equality(&result, &[f32::NAN, f32::NAN, f32::NAN, f32::NAN]).map_err(|e| format!("{e} | call: _mm_cmpunord_ps(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpunord_ps_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpunord_ps_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpunord_ps_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpunord_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpunord_ps(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpunord_ps_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpunord_ps_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpunord_ps_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpunord_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpunord_ps(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpunord_ps_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpunord_ps_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cmpunord_ps_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cmpunord_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN])));
        check_float_array_equality(&result, &[0.0; 4]).map_err(|e| format!("{e} | call: _mm_cmpunord_ps(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cmpunord_ps(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cmpunord_ps_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cmpunord_ps_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comieq_ss_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comieq_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comieq_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comieq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comieq_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comieq_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comieq_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comieq_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comieq_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comieq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comieq_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comieq_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comieq_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comieq_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comieq_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comieq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comieq_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comieq_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comieq_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comieq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comieq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comieq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comieq_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comieq_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comieq_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comieq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comieq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comieq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comieq_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comieq_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comieq_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comieq_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comieq_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comieq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comieq_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comieq_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comieq_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comieq_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comieq_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comieq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comieq_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comieq_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comieq_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comieq_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comieq_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comieq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comieq_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comieq_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comieq_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comieq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comieq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comieq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comieq_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comieq_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comieq_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comieq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comieq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comieq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comieq_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comieq_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comilt_ss_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comilt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comilt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comilt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comilt_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comilt_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comilt_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comilt_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comilt_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comilt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comilt_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comilt_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comilt_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comilt_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comilt_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comilt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comilt_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comilt_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comilt_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comilt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comilt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comilt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comilt_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comilt_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comilt_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comilt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comilt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comilt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comilt_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comilt_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comilt_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comilt_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comilt_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comilt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comilt_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comilt_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comilt_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comilt_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comilt_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comilt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comilt_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comilt_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comilt_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comilt_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comilt_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comilt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comilt_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comilt_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comilt_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comilt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comilt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comilt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comilt_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comilt_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comilt_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comilt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comilt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comilt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comilt_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comilt_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comile_ss_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comile_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comile_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comile_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comile_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comile_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comile_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comile_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comile_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comile_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comile_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comile_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comile_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comile_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comile_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comile_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comile_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comile_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comile_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comile_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comile_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comile_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comile_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comile_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comile_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comile_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comile_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comile_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comile_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comile_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comile_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comile_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comile_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comile_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comile_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comile_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comile_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comile_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comile_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comile_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comile_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comile_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comile_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comile_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comile_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comile_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comile_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comile_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comile_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comile_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comile_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comile_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comile_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comile_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comile_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comile_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comile_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comile_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comile_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comile_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comigt_ss_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comigt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comigt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comigt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comigt_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comigt_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comigt_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comigt_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comigt_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comigt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comigt_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comigt_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comigt_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comigt_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comigt_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comigt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comigt_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comigt_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comigt_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comigt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comigt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comigt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comigt_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comigt_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comigt_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comigt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comigt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comigt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comigt_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comigt_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comigt_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comigt_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comigt_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comigt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comigt_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comigt_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comigt_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comigt_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comigt_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comigt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comigt_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comigt_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comigt_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comigt_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comigt_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comigt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comigt_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comigt_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comigt_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comigt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comigt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comigt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comigt_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comigt_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comigt_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comigt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comigt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comigt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comigt_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comigt_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comige_ss_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comige_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comige_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comige_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comige_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comige_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comige_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comige_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comige_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comige_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comige_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comige_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comige_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comige_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comige_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comige_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comige_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comige_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comige_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comige_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comige_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comige_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comige_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comige_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comige_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comige_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comige_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comige_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comige_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comige_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comige_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comige_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comige_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comige_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comige_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comige_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comige_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comige_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comige_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comige_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comige_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comige_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comige_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comige_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comige_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comige_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comige_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comige_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comige_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comige_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comige_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comige_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comige_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comige_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comige_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comige_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comige_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comige_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comige_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comige_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comineq_ss_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comineq_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comineq_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comineq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comineq_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comineq_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comineq_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comineq_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comineq_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comineq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comineq_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comineq_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comineq_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comineq_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comineq_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comineq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comineq_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comineq_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comineq_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comineq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comineq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comineq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comineq_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comineq_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comineq_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comineq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comineq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comineq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comineq_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comineq_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comineq_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comineq_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comineq_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comineq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comineq_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comineq_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comineq_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comineq_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comineq_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comineq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comineq_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comineq_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comineq_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comineq_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_comineq_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comineq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comineq_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comineq_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comineq_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comineq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comineq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comineq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comineq_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comineq_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_comineq_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_comineq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_comineq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_comineq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_comineq_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_comineq_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomieq_ss_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomieq_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomieq_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomieq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomieq_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomieq_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomieq_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomieq_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomieq_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomieq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomieq_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomieq_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomieq_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomieq_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomieq_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomieq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomieq_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomieq_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomieq_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomieq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomieq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomieq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomieq_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomieq_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomieq_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomieq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomieq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomieq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomieq_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomieq_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomieq_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomieq_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomieq_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomieq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomieq_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomieq_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomieq_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomieq_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomieq_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomieq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomieq_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomieq_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomieq_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomieq_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomieq_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomieq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomieq_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomieq_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomieq_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomieq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomieq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomieq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomieq_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomieq_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomieq_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomieq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomieq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomieq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomieq_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomieq_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomilt_ss_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomilt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomilt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomilt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomilt_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomilt_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomilt_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomilt_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomilt_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomilt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomilt_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomilt_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomilt_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomilt_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomilt_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomilt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomilt_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomilt_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomilt_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomilt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomilt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomilt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomilt_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomilt_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomilt_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomilt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomilt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomilt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomilt_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomilt_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomilt_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomilt_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomilt_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomilt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomilt_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomilt_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomilt_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomilt_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomilt_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomilt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomilt_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomilt_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomilt_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomilt_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomilt_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomilt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomilt_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomilt_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomilt_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomilt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomilt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomilt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomilt_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomilt_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomilt_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomilt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomilt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomilt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomilt_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomilt_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomile_ss_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomile_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomile_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomile_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomile_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomile_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomile_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomile_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomile_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomile_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomile_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomile_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomile_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomile_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomile_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomile_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomile_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomile_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomile_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomile_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomile_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomile_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomile_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomile_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomile_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomile_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomile_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomile_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomile_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomile_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomile_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomile_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomile_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomile_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomile_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomile_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomile_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomile_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomile_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomile_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomile_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomile_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomile_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomile_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomile_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomile_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomile_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomile_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomile_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomile_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomile_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomile_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomile_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomile_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomile_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomile_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomile_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomile_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomile_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomile_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomigt_ss_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomigt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomigt_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomigt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomigt_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomigt_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomigt_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomigt_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomigt_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomigt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomigt_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomigt_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomigt_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomigt_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomigt_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomigt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomigt_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomigt_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomigt_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomigt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomigt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomigt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomigt_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomigt_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomigt_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomigt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomigt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomigt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomigt_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomigt_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomigt_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomigt_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomigt_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomigt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomigt_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomigt_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomigt_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomigt_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomigt_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomigt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomigt_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomigt_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomigt_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomigt_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomigt_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomigt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomigt_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomigt_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomigt_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomigt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomigt_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomigt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomigt_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomigt_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomigt_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomigt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomigt_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomigt_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomigt_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomigt_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomige_ss_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomige_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomige_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomige_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomige_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomige_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomige_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomige_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomige_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomige_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomige_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomige_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomige_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomige_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomige_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomige_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomige_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomige_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomige_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomige_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomige_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomige_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomige_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomige_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomige_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomige_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomige_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomige_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomige_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomige_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomige_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomige_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomige_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomige_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomige_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomige_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomige_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomige_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomige_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomige_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomige_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomige_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomige_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomige_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomige_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomige_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomige_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomige_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomige_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomige_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomige_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomige_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomige_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomige_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomige_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomige_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomige_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomige_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomige_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomige_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomineq_ss_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomineq_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomineq_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([5.0, 6.0, 7.0, 8.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomineq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomineq_ss() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomineq_ss_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomineq_ss_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomineq_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomineq_ss(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]), create__m128_from([10.0f32, 9.0f32, 12.0f32, 7.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomineq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomineq_ss_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomineq_ss_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomineq_ss_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomineq_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomineq_ss(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]), create__m128_from([110.0f32, 210.0f32, 310.0f32, 410.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomineq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomineq_ss_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomineq_ss_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomineq_ss_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomineq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomineq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomineq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomineq_ss_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomineq_ss_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomineq_ss_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomineq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomineq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomineq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomineq_ss_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomineq_ss_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomineq_ss_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomineq_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomineq_ss(create__m128_from([0.0, 0.0, 0.0, 0.0]), create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomineq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomineq_ss_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomineq_ss_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomineq_ss_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomineq_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomineq_ss(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]), create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomineq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomineq_ss_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomineq_ss_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomineq_ss_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomineq_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_ucomineq_ss(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]), create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomineq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomineq_ss_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomineq_ss_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomineq_ss_asym_min_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomineq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomineq_ss(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]), create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomineq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomineq_ss_asym_min_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomineq_ss_asym_min_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_ucomineq_ss_asym_max_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_ucomineq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_ucomineq_ss(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]), create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_ucomineq_ss(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_ucomineq_ss_asym_max_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_ucomineq_ss_asym_max_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_si32_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_si32(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvtss_si32(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_si32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvtss_si32() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvtss_si32_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_si32_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_si32(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtss_si32(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_si32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvtss_si32_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvtss_si32_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_si32_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_si32(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvtss_si32(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_si32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvtss_si32_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvtss_si32_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_si32_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_si32(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvtss_si32(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_si32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvtss_si32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvtss_si32_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_si32_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_si32(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvtss_si32(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_si32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvtss_si32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvtss_si32_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_si32_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_si32(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtss_si32(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_si32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvtss_si32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvtss_si32_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_si32_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_si32(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvtss_si32(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_si32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvtss_si32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvtss_si32_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtss_si32_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_si32(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvtss_si32(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtss_si32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvtss_si32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvtss_si32_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvt_ss2si_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_ss2si(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvt_ss2si(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_ss2si(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvt_ss2si() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvt_ss2si_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvt_ss2si_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_ss2si(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_ss2si(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_ss2si(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvt_ss2si_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvt_ss2si_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvt_ss2si_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_ss2si(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvt_ss2si(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_ss2si(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvt_ss2si_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvt_ss2si_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvt_ss2si_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_ss2si(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvt_ss2si(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_ss2si(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvt_ss2si_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvt_ss2si_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvt_ss2si_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_ss2si(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvt_ss2si(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_ss2si(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvt_ss2si_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvt_ss2si_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvt_ss2si_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_ss2si(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvt_ss2si(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_ss2si(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvt_ss2si_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvt_ss2si_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvt_ss2si_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_ss2si(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvt_ss2si(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_ss2si(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvt_ss2si_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvt_ss2si_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvt_ss2si_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_ss2si(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvt_ss2si(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvt_ss2si(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvt_ss2si_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvt_ss2si_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvttss_si32_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttss_si32(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvttss_si32(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_si32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvttss_si32() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvttss_si32_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvttss_si32_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttss_si32(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttss_si32(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_si32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvttss_si32_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvttss_si32_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvttss_si32_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttss_si32(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvttss_si32(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_si32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvttss_si32_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvttss_si32_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvttss_si32_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttss_si32(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvttss_si32(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_si32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvttss_si32_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvttss_si32_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvttss_si32_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttss_si32(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvttss_si32(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_si32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvttss_si32_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvttss_si32_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvttss_si32_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttss_si32(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvttss_si32(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_si32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvttss_si32_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvttss_si32_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvttss_si32_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttss_si32(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvttss_si32(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_si32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvttss_si32_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvttss_si32_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvttss_si32_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttss_si32(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvttss_si32(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvttss_si32(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvttss_si32_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvttss_si32_boundary_mixed_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtt_ss2si_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_ss2si(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 1).map_err(|e| format!("{e} | call: _mm_cvtt_ss2si(create__m128_from([1.0, 2.0, 3.0, 4.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_ss2si(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvtt_ss2si() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvtt_ss2si_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtt_ss2si_normal2_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_ss2si(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_ss2si(create__m128_from([0.0f32, -1.0f32, 2.0f32, -3.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_ss2si(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvtt_ss2si_normal2() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvtt_ss2si_normal2_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtt_ss2si_normal3_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_ss2si(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]));
        check_int_equality(result as i32, 100).map_err(|e| format!("{e} | call: _mm_cvtt_ss2si(create__m128_from([100.0f32, 200.0f32, 300.0f32, 400.0f32]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_ss2si(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvtt_ss2si_normal3() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvtt_ss2si_normal3_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtt_ss2si_boundary_min_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_ss2si(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvtt_ss2si(create__m128_from([f32::MIN, f32::MIN, f32::MIN, f32::MIN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_ss2si(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvtt_ss2si_boundary_min() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvtt_ss2si_boundary_min_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtt_ss2si_boundary_max_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_ss2si(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvtt_ss2si(create__m128_from([f32::MAX, f32::MAX, f32::MAX, f32::MAX]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_ss2si(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvtt_ss2si_boundary_max() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvtt_ss2si_boundary_max_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtt_ss2si_boundary_zero_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_ss2si(create__m128_from([0.0, 0.0, 0.0, 0.0]));
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: _mm_cvtt_ss2si(create__m128_from([0.0, 0.0, 0.0, 0.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_ss2si(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvtt_ss2si_boundary_zero() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvtt_ss2si_boundary_zero_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtt_ss2si_boundary_allones_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_ss2si(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvtt_ss2si(create__m128_from([f32::NAN, f32::NAN, f32::NAN, f32::NAN]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_ss2si(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvtt_ss2si_boundary_allones() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvtt_ss2si_boundary_allones_impl() }
}

#[target_feature(enable = "sse")]
fn test_x86_sse_mm_cvtt_ss2si_boundary_mixed_impl() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_ss2si(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]));
        check_int_equality(result as i32, -2147483648).map_err(|e| format!("{e} | call: _mm_cvtt_ss2si(create__m128_from([f32::INFINITY, f32::NEG_INFINITY, -0.0, f32::MIN_POSITIVE / 2.0]))"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtt_ss2si(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_x86_sse_mm_cvtt_ss2si_boundary_mixed() -> Result<(), String> {
    unsafe { test_x86_sse_mm_cvtt_ss2si_boundary_mixed_impl() }
}
