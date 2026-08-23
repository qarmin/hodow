use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_wasm32_relaxed_simd_i8x16_relaxed_swizzle() -> Result<(), String> {
    unsafe {
        let _result = i8x16_relaxed_swizzle(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_relaxed_swizzle(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_relaxed_simd_i32x4_relaxed_trunc_f32x4() -> Result<(), String> {
    unsafe {
        let _result = i32x4_relaxed_trunc_f32x4(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_relaxed_trunc_f32x4(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_relaxed_simd_u32x4_relaxed_trunc_f32x4() -> Result<(), String> {
    unsafe {
        let _result = u32x4_relaxed_trunc_f32x4(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u32x4_relaxed_trunc_f32x4(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_relaxed_simd_i32x4_relaxed_trunc_f64x2_zero() -> Result<(), String> {
    unsafe {
        let _result = i32x4_relaxed_trunc_f64x2_zero(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_relaxed_trunc_f64x2_zero(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_relaxed_simd_u32x4_relaxed_trunc_f64x2_zero() -> Result<(), String> {
    unsafe {
        let _result = u32x4_relaxed_trunc_f64x2_zero(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u32x4_relaxed_trunc_f64x2_zero(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_relaxed_simd_f32x4_relaxed_madd() -> Result<(), String> {
    unsafe {
        let _result = f32x4_relaxed_madd(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_relaxed_madd(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_relaxed_simd_f32x4_relaxed_nmadd() -> Result<(), String> {
    unsafe {
        let _result = f32x4_relaxed_nmadd(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_relaxed_nmadd(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_relaxed_simd_f64x2_relaxed_madd() -> Result<(), String> {
    unsafe {
        let _result = f64x2_relaxed_madd(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_relaxed_madd(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_relaxed_simd_f64x2_relaxed_nmadd() -> Result<(), String> {
    unsafe {
        let _result = f64x2_relaxed_nmadd(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_relaxed_nmadd(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_relaxed_simd_i8x16_relaxed_laneselect() -> Result<(), String> {
    unsafe {
        let _result = i8x16_relaxed_laneselect(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_relaxed_laneselect(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_relaxed_simd_i16x8_relaxed_laneselect() -> Result<(), String> {
    unsafe {
        let _result = i16x8_relaxed_laneselect(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_relaxed_laneselect(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_relaxed_simd_i32x4_relaxed_laneselect() -> Result<(), String> {
    unsafe {
        let _result = i32x4_relaxed_laneselect(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_relaxed_laneselect(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_relaxed_simd_i64x2_relaxed_laneselect() -> Result<(), String> {
    unsafe {
        let _result = i64x2_relaxed_laneselect(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_relaxed_laneselect(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_relaxed_simd_f32x4_relaxed_min() -> Result<(), String> {
    unsafe {
        let _result = f32x4_relaxed_min(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_relaxed_min(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_relaxed_simd_f32x4_relaxed_max() -> Result<(), String> {
    unsafe {
        let _result = f32x4_relaxed_max(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_relaxed_max(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_relaxed_simd_f64x2_relaxed_min() -> Result<(), String> {
    unsafe {
        let _result = f64x2_relaxed_min(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_relaxed_min(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_relaxed_simd_f64x2_relaxed_max() -> Result<(), String> {
    unsafe {
        let _result = f64x2_relaxed_max(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_relaxed_max(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_relaxed_simd_i16x8_relaxed_q15mulr() -> Result<(), String> {
    unsafe {
        let _result = i16x8_relaxed_q15mulr(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_relaxed_q15mulr(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_relaxed_simd_i16x8_relaxed_dot_i8x16_i7x16() -> Result<(), String> {
    unsafe {
        let _result = i16x8_relaxed_dot_i8x16_i7x16(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_relaxed_dot_i8x16_i7x16(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_wasm32_relaxed_simd_i32x4_relaxed_dot_i8x16_i7x16_add() -> Result<(), String> {
    unsafe {
        let _result = i32x4_relaxed_dot_i8x16_i7x16_add(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_relaxed_dot_i8x16_i7x16_add(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}
