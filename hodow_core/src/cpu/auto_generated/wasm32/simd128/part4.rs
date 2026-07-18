use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_i16x8_add_sat() -> Result<(), String> {
    unsafe {
        let _result = i16x8_add_sat(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_add_sat(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u16x8_add_sat() -> Result<(), String> {
    unsafe {
        let _result = u16x8_add_sat(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u16x8_add_sat(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_sub() -> Result<(), String> {
    unsafe {
        let _result = i16x8_sub(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_sub(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_sub_sat() -> Result<(), String> {
    unsafe {
        let _result = i16x8_sub_sat(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_sub_sat(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u16x8_sub_sat() -> Result<(), String> {
    unsafe {
        let _result = u16x8_sub_sat(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u16x8_sub_sat(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_mul() -> Result<(), String> {
    unsafe {
        let _result = i16x8_mul(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_mul(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_min() -> Result<(), String> {
    unsafe {
        let _result = i16x8_min(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_min(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u16x8_min() -> Result<(), String> {
    unsafe {
        let _result = u16x8_min(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u16x8_min(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_max() -> Result<(), String> {
    unsafe {
        let _result = i16x8_max(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_max(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u16x8_max() -> Result<(), String> {
    unsafe {
        let _result = u16x8_max(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u16x8_max(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u16x8_avgr() -> Result<(), String> {
    unsafe {
        let _result = u16x8_avgr(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u16x8_avgr(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_extmul_low_i8x16() -> Result<(), String> {
    unsafe {
        let _result = i16x8_extmul_low_i8x16(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_extmul_low_i8x16(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_extmul_high_i8x16() -> Result<(), String> {
    unsafe {
        let _result = i16x8_extmul_high_i8x16(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_extmul_high_i8x16(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_extmul_low_u8x16() -> Result<(), String> {
    unsafe {
        let _result = i16x8_extmul_low_u8x16(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_extmul_low_u8x16(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_extmul_high_u8x16() -> Result<(), String> {
    unsafe {
        let _result = i16x8_extmul_high_u8x16(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_extmul_high_u8x16(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_extadd_pairwise_i16x8() -> Result<(), String> {
    unsafe {
        let _result = i32x4_extadd_pairwise_i16x8(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_extadd_pairwise_i16x8(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_extadd_pairwise_u16x8() -> Result<(), String> {
    unsafe {
        let _result = i32x4_extadd_pairwise_u16x8(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_extadd_pairwise_u16x8(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_abs() -> Result<(), String> {
    unsafe {
        let _result = i32x4_abs(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_abs(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_neg() -> Result<(), String> {
    unsafe {
        let _result = i32x4_neg(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_neg(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_all_true() -> Result<(), String> {
    unsafe {
        let _result = i32x4_all_true(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_all_true(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_bitmask() -> Result<(), String> {
    unsafe {
        let result = i32x4_bitmask(0 /* v128 */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_bitmask(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_extend_low_i16x8() -> Result<(), String> {
    unsafe {
        let _result = i32x4_extend_low_i16x8(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_extend_low_i16x8(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_extend_high_i16x8() -> Result<(), String> {
    unsafe {
        let _result = i32x4_extend_high_i16x8(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_extend_high_i16x8(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_extend_low_u16x8() -> Result<(), String> {
    unsafe {
        let _result = i32x4_extend_low_u16x8(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_extend_low_u16x8(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_extend_high_u16x8() -> Result<(), String> {
    unsafe {
        let _result = i32x4_extend_high_u16x8(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_extend_high_u16x8(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_shl() -> Result<(), String> {
    unsafe {
        let _result = i32x4_shl(0 /* v128 */, 1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_shl(0 /* v128 */, rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_shr() -> Result<(), String> {
    unsafe {
        let _result = i32x4_shr(0 /* v128 */, 1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_shr(0 /* v128 */, rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_u32x4_shr() -> Result<(), String> {
    unsafe {
        let _result = u32x4_shr(0 /* v128 */, 1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u32x4_shr(0 /* v128 */, rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_add() -> Result<(), String> {
    unsafe {
        let _result = i32x4_add(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_add(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_sub() -> Result<(), String> {
    unsafe {
        let _result = i32x4_sub(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_sub(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_mul() -> Result<(), String> {
    unsafe {
        let _result = i32x4_mul(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_mul(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_min() -> Result<(), String> {
    unsafe {
        let _result = i32x4_min(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_min(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u32x4_min() -> Result<(), String> {
    unsafe {
        let _result = u32x4_min(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u32x4_min(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_max() -> Result<(), String> {
    unsafe {
        let _result = i32x4_max(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_max(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u32x4_max() -> Result<(), String> {
    unsafe {
        let _result = u32x4_max(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u32x4_max(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_dot_i16x8() -> Result<(), String> {
    unsafe {
        let _result = i32x4_dot_i16x8(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_dot_i16x8(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_extmul_low_i16x8() -> Result<(), String> {
    unsafe {
        let _result = i32x4_extmul_low_i16x8(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_extmul_low_i16x8(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_extmul_high_i16x8() -> Result<(), String> {
    unsafe {
        let _result = i32x4_extmul_high_i16x8(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_extmul_high_i16x8(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_extmul_low_u16x8() -> Result<(), String> {
    unsafe {
        let _result = i32x4_extmul_low_u16x8(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_extmul_low_u16x8(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i32x4_extmul_high_u16x8() -> Result<(), String> {
    unsafe {
        let _result = i32x4_extmul_high_u16x8(0 /* v128 */, 0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i32x4_extmul_high_u16x8(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i64x2_abs() -> Result<(), String> {
    unsafe {
        let _result = i64x2_abs(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_abs(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i64x2_neg() -> Result<(), String> {
    unsafe {
        let _result = i64x2_neg(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_neg(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i64x2_all_true() -> Result<(), String> {
    unsafe {
        let _result = i64x2_all_true(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_all_true(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i64x2_bitmask() -> Result<(), String> {
    unsafe {
        let result = i64x2_bitmask(0 /* v128 */);
        check_int_equality(result as i32, 0)?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_bitmask(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i64x2_extend_low_i32x4() -> Result<(), String> {
    unsafe {
        let _result = i64x2_extend_low_i32x4(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_extend_low_i32x4(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i64x2_extend_high_i32x4() -> Result<(), String> {
    unsafe {
        let _result = i64x2_extend_high_i32x4(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_extend_high_i32x4(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i64x2_extend_low_u32x4() -> Result<(), String> {
    unsafe {
        let _result = i64x2_extend_low_u32x4(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_extend_low_u32x4(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i64x2_extend_high_u32x4() -> Result<(), String> {
    unsafe {
        let _result = i64x2_extend_high_u32x4(0 /* v128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_extend_high_u32x4(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i64x2_shl() -> Result<(), String> {
    unsafe {
        let _result = i64x2_shl(0 /* v128 */, 1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_shl(0 /* v128 */, rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_i64x2_shr() -> Result<(), String> {
    unsafe {
        let _result = i64x2_shr(0 /* v128 */, 1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i64x2_shr(0 /* v128 */, rand::random::<u32>());
            }
        }
    }
    Ok(())
}
