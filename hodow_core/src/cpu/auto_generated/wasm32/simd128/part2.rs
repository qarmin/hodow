use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_u16x8_splat() -> Result<(), String> {
    unsafe {
        let _result = u16x8_splat(1u16);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u16x8_splat(rand::random::<u16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_splat() -> Result<(), String> {
    unsafe {
        let _result = i32x4_splat(1i32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_splat(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_u32x4_splat() -> Result<(), String> {
    unsafe {
        let _result = u32x4_splat(1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u32x4_splat(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_i64x2_splat() -> Result<(), String> {
    unsafe {
        let _result = i64x2_splat(1i64);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_splat(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_u64x2_splat() -> Result<(), String> {
    unsafe {
        let _result = u64x2_splat(1u64);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u64x2_splat(rand::random::<u64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_f32x4_splat() -> Result<(), String> {
    unsafe {
        let _result = f32x4_splat(1.0f32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_splat(rand::random::<f32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_f64x2_splat() -> Result<(), String> {
    unsafe {
        let _result = f64x2_splat(1.0f64);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_splat(rand::random::<f64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_i8x16_eq() -> Result<(), String> {
    unsafe {
        let _result = i8x16_eq(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_eq(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i8x16_ne() -> Result<(), String> {
    unsafe {
        let _result = i8x16_ne(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_ne(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i8x16_lt() -> Result<(), String> {
    unsafe {
        let _result = i8x16_lt(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_lt(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u8x16_lt() -> Result<(), String> {
    unsafe {
        let _result = u8x16_lt(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u8x16_lt(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i8x16_gt() -> Result<(), String> {
    unsafe {
        let _result = i8x16_gt(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_gt(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u8x16_gt() -> Result<(), String> {
    unsafe {
        let _result = u8x16_gt(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u8x16_gt(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i8x16_le() -> Result<(), String> {
    unsafe {
        let _result = i8x16_le(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_le(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u8x16_le() -> Result<(), String> {
    unsafe {
        let _result = u8x16_le(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u8x16_le(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i8x16_ge() -> Result<(), String> {
    unsafe {
        let _result = i8x16_ge(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_ge(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u8x16_ge() -> Result<(), String> {
    unsafe {
        let _result = u8x16_ge(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u8x16_ge(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_eq() -> Result<(), String> {
    unsafe {
        let _result = i16x8_eq(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_eq(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_ne() -> Result<(), String> {
    unsafe {
        let _result = i16x8_ne(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_ne(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_lt() -> Result<(), String> {
    unsafe {
        let _result = i16x8_lt(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_lt(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u16x8_lt() -> Result<(), String> {
    unsafe {
        let _result = u16x8_lt(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u16x8_lt(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_gt() -> Result<(), String> {
    unsafe {
        let _result = i16x8_gt(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_gt(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u16x8_gt() -> Result<(), String> {
    unsafe {
        let _result = u16x8_gt(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u16x8_gt(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_le() -> Result<(), String> {
    unsafe {
        let _result = i16x8_le(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_le(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u16x8_le() -> Result<(), String> {
    unsafe {
        let _result = u16x8_le(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u16x8_le(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_ge() -> Result<(), String> {
    unsafe {
        let _result = i16x8_ge(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_ge(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u16x8_ge() -> Result<(), String> {
    unsafe {
        let _result = u16x8_ge(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u16x8_ge(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_eq() -> Result<(), String> {
    unsafe {
        let _result = i32x4_eq(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_eq(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_ne() -> Result<(), String> {
    unsafe {
        let _result = i32x4_ne(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_ne(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_lt() -> Result<(), String> {
    unsafe {
        let _result = i32x4_lt(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_lt(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u32x4_lt() -> Result<(), String> {
    unsafe {
        let _result = u32x4_lt(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u32x4_lt(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_gt() -> Result<(), String> {
    unsafe {
        let _result = i32x4_gt(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_gt(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u32x4_gt() -> Result<(), String> {
    unsafe {
        let _result = u32x4_gt(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u32x4_gt(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_le() -> Result<(), String> {
    unsafe {
        let _result = i32x4_le(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_le(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u32x4_le() -> Result<(), String> {
    unsafe {
        let _result = u32x4_le(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u32x4_le(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_ge() -> Result<(), String> {
    unsafe {
        let _result = i32x4_ge(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_ge(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u32x4_ge() -> Result<(), String> {
    unsafe {
        let _result = u32x4_ge(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u32x4_ge(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i64x2_eq() -> Result<(), String> {
    unsafe {
        let _result = i64x2_eq(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_eq(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i64x2_ne() -> Result<(), String> {
    unsafe {
        let _result = i64x2_ne(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_ne(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i64x2_lt() -> Result<(), String> {
    unsafe {
        let _result = i64x2_lt(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_lt(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i64x2_gt() -> Result<(), String> {
    unsafe {
        let _result = i64x2_gt(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_gt(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i64x2_le() -> Result<(), String> {
    unsafe {
        let _result = i64x2_le(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_le(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i64x2_ge() -> Result<(), String> {
    unsafe {
        let _result = i64x2_ge(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_ge(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_f32x4_eq() -> Result<(), String> {
    unsafe {
        let _result = f32x4_eq(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_eq(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_f32x4_ne() -> Result<(), String> {
    unsafe {
        let _result = f32x4_ne(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_ne(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_f32x4_lt() -> Result<(), String> {
    unsafe {
        let _result = f32x4_lt(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_lt(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_f32x4_gt() -> Result<(), String> {
    unsafe {
        let _result = f32x4_gt(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_gt(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_f32x4_le() -> Result<(), String> {
    unsafe {
        let _result = f32x4_le(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_le(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_f32x4_ge() -> Result<(), String> {
    unsafe {
        let _result = f32x4_ge(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f32x4_ge(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_f64x2_eq() -> Result<(), String> {
    unsafe {
        let _result = f64x2_eq(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_eq(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}
