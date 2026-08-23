use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_wasm32_simd128_u64x2_shr() -> Result<(), String> {
    unsafe {
        let _result = u64x2_shr(0 /* v128 */, 1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u64x2_shr(0 /* v128 */, rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i64x2_add() -> Result<(), String> {
    unsafe {
        let _result = i64x2_add(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_add(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i64x2_sub() -> Result<(), String> {
    unsafe {
        let _result = i64x2_sub(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_sub(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i64x2_mul() -> Result<(), String> {
    unsafe {
        let _result = i64x2_mul(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_mul(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i64x2_extmul_low_i32x4() -> Result<(), String> {
    unsafe {
        let _result = i64x2_extmul_low_i32x4(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_extmul_low_i32x4(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i64x2_extmul_high_i32x4() -> Result<(), String> {
    unsafe {
        let _result = i64x2_extmul_high_i32x4(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_extmul_high_i32x4(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i64x2_extmul_low_u32x4() -> Result<(), String> {
    unsafe {
        let _result = i64x2_extmul_low_u32x4(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_extmul_low_u32x4(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i64x2_extmul_high_u32x4() -> Result<(), String> {
    unsafe {
        let _result = i64x2_extmul_high_u32x4(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_extmul_high_u32x4(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f32x4_ceil() -> Result<(), String> {
    unsafe {
        let _result = f32x4_ceil(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_ceil(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f32x4_floor() -> Result<(), String> {
    unsafe {
        let _result = f32x4_floor(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_floor(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f32x4_trunc() -> Result<(), String> {
    unsafe {
        let _result = f32x4_trunc(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_trunc(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f32x4_nearest() -> Result<(), String> {
    unsafe {
        let _result = f32x4_nearest(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_nearest(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f32x4_abs() -> Result<(), String> {
    unsafe {
        let _result = f32x4_abs(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_abs(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f32x4_neg() -> Result<(), String> {
    unsafe {
        let _result = f32x4_neg(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_neg(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f32x4_sqrt() -> Result<(), String> {
    unsafe {
        let _result = f32x4_sqrt(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_sqrt(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f32x4_add() -> Result<(), String> {
    unsafe {
        let _result = f32x4_add(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_add(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f32x4_sub() -> Result<(), String> {
    unsafe {
        let _result = f32x4_sub(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_sub(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f32x4_mul() -> Result<(), String> {
    unsafe {
        let _result = f32x4_mul(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_mul(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f32x4_div() -> Result<(), String> {
    unsafe {
        let _result = f32x4_div(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_div(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f32x4_min() -> Result<(), String> {
    unsafe {
        let _result = f32x4_min(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_min(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f32x4_max() -> Result<(), String> {
    unsafe {
        let _result = f32x4_max(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_max(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f32x4_pmin() -> Result<(), String> {
    unsafe {
        let _result = f32x4_pmin(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_pmin(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f32x4_pmax() -> Result<(), String> {
    unsafe {
        let _result = f32x4_pmax(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_pmax(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f64x2_ceil() -> Result<(), String> {
    unsafe {
        let _result = f64x2_ceil(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_ceil(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f64x2_floor() -> Result<(), String> {
    unsafe {
        let _result = f64x2_floor(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_floor(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f64x2_trunc() -> Result<(), String> {
    unsafe {
        let _result = f64x2_trunc(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_trunc(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f64x2_nearest() -> Result<(), String> {
    unsafe {
        let _result = f64x2_nearest(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_nearest(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f64x2_abs() -> Result<(), String> {
    unsafe {
        let _result = f64x2_abs(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_abs(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f64x2_neg() -> Result<(), String> {
    unsafe {
        let _result = f64x2_neg(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_neg(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f64x2_sqrt() -> Result<(), String> {
    unsafe {
        let _result = f64x2_sqrt(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_sqrt(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f64x2_add() -> Result<(), String> {
    unsafe {
        let _result = f64x2_add(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_add(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f64x2_sub() -> Result<(), String> {
    unsafe {
        let _result = f64x2_sub(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_sub(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f64x2_mul() -> Result<(), String> {
    unsafe {
        let _result = f64x2_mul(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_mul(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f64x2_div() -> Result<(), String> {
    unsafe {
        let _result = f64x2_div(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_div(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f64x2_min() -> Result<(), String> {
    unsafe {
        let _result = f64x2_min(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_min(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f64x2_max() -> Result<(), String> {
    unsafe {
        let _result = f64x2_max(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_max(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f64x2_pmin() -> Result<(), String> {
    unsafe {
        let _result = f64x2_pmin(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_pmin(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f64x2_pmax() -> Result<(), String> {
    unsafe {
        let _result = f64x2_pmax(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_pmax(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i32x4_trunc_sat_f32x4() -> Result<(), String> {
    unsafe {
        let _result = i32x4_trunc_sat_f32x4(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_trunc_sat_f32x4(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_u32x4_trunc_sat_f32x4() -> Result<(), String> {
    unsafe {
        let _result = u32x4_trunc_sat_f32x4(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u32x4_trunc_sat_f32x4(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f32x4_convert_i32x4() -> Result<(), String> {
    unsafe {
        let _result = f32x4_convert_i32x4(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_convert_i32x4(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f32x4_convert_u32x4() -> Result<(), String> {
    unsafe {
        let _result = f32x4_convert_u32x4(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_convert_u32x4(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_i32x4_trunc_sat_f64x2_zero() -> Result<(), String> {
    unsafe {
        let _result = i32x4_trunc_sat_f64x2_zero(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_trunc_sat_f64x2_zero(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_u32x4_trunc_sat_f64x2_zero() -> Result<(), String> {
    unsafe {
        let _result = u32x4_trunc_sat_f64x2_zero(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u32x4_trunc_sat_f64x2_zero(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f64x2_convert_low_i32x4() -> Result<(), String> {
    unsafe {
        let _result = f64x2_convert_low_i32x4(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_convert_low_i32x4(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f64x2_convert_low_u32x4() -> Result<(), String> {
    unsafe {
        let _result = f64x2_convert_low_u32x4(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_convert_low_u32x4(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f32x4_demote_f64x2_zero() -> Result<(), String> {
    unsafe {
        let _result = f32x4_demote_f64x2_zero(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_demote_f64x2_zero(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_simd128_f64x2_promote_low_f32x4() -> Result<(), String> {
    unsafe {
        let _result = f64x2_promote_low_f32x4(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_promote_low_f32x4(0 /* v128 */);
            }
        }
    }
    Ok(())
}
