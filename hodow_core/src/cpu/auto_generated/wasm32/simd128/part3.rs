use std::arch::wasm32::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_f64x2_ne() -> Result<(), String> {
    unsafe {
        let _result = f64x2_ne(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_ne(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_f64x2_lt() -> Result<(), String> {
    unsafe {
        let _result = f64x2_lt(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_lt(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_f64x2_gt() -> Result<(), String> {
    unsafe {
        let _result = f64x2_gt(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_gt(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_f64x2_le() -> Result<(), String> {
    unsafe {
        let _result = f64x2_le(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_le(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_f64x2_ge() -> Result<(), String> {
    unsafe {
        let _result = f64x2_ge(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = f64x2_ge(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_v128_not() -> Result<(), String> {
    unsafe {
        let _result = v128_not(0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = v128_not(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_v128_and() -> Result<(), String> {
    unsafe {
        let _result = v128_and(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = v128_and(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_v128_andnot() -> Result<(), String> {
    unsafe {
        let _result = v128_andnot(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = v128_andnot(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_v128_or() -> Result<(), String> {
    unsafe {
        let _result = v128_or(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = v128_or(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_v128_xor() -> Result<(), String> {
    unsafe {
        let _result = v128_xor(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = v128_xor(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_v128_bitselect() -> Result<(), String> {
    unsafe {
        let _result = v128_bitselect(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = v128_bitselect(0 /* v128 */, 0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_v128_any_true() -> Result<(), String> {
    unsafe {
        let _result = v128_any_true(0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = v128_any_true(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i8x16_abs() -> Result<(), String> {
    unsafe {
        let _result = i8x16_abs(0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_abs(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i8x16_neg() -> Result<(), String> {
    unsafe {
        let _result = i8x16_neg(0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_neg(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i8x16_popcnt() -> Result<(), String> {
    unsafe {
        let _result = i8x16_popcnt(0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_popcnt(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i8x16_all_true() -> Result<(), String> {
    unsafe {
        let _result = i8x16_all_true(0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_all_true(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i8x16_bitmask() -> Result<(), String> {
    unsafe {
        let result = i8x16_bitmask(0 /* v128 */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_bitmask(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i8x16_narrow_i16x8() -> Result<(), String> {
    unsafe {
        let _result = i8x16_narrow_i16x8(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_narrow_i16x8(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u8x16_narrow_i16x8() -> Result<(), String> {
    unsafe {
        let _result = u8x16_narrow_i16x8(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u8x16_narrow_i16x8(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i8x16_shl() -> Result<(), String> {
    unsafe {
        let _result = i8x16_shl(0 /* v128 */, 1u32);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_shl(0 /* v128 */, rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_i8x16_shr() -> Result<(), String> {
    unsafe {
        let _result = i8x16_shr(0 /* v128 */, 1u32);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_shr(0 /* v128 */, rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_u8x16_shr() -> Result<(), String> {
    unsafe {
        let _result = u8x16_shr(0 /* v128 */, 1u32);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u8x16_shr(0 /* v128 */, rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_i8x16_add() -> Result<(), String> {
    unsafe {
        let _result = i8x16_add(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_add(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i8x16_add_sat() -> Result<(), String> {
    unsafe {
        let _result = i8x16_add_sat(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_add_sat(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u8x16_add_sat() -> Result<(), String> {
    unsafe {
        let _result = u8x16_add_sat(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u8x16_add_sat(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i8x16_sub() -> Result<(), String> {
    unsafe {
        let _result = i8x16_sub(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_sub(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i8x16_sub_sat() -> Result<(), String> {
    unsafe {
        let _result = i8x16_sub_sat(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_sub_sat(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u8x16_sub_sat() -> Result<(), String> {
    unsafe {
        let _result = u8x16_sub_sat(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u8x16_sub_sat(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i8x16_min() -> Result<(), String> {
    unsafe {
        let _result = i8x16_min(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_min(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u8x16_min() -> Result<(), String> {
    unsafe {
        let _result = u8x16_min(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u8x16_min(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i8x16_max() -> Result<(), String> {
    unsafe {
        let _result = i8x16_max(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i8x16_max(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u8x16_max() -> Result<(), String> {
    unsafe {
        let _result = u8x16_max(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u8x16_max(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u8x16_avgr() -> Result<(), String> {
    unsafe {
        let _result = u8x16_avgr(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u8x16_avgr(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_extadd_pairwise_i8x16() -> Result<(), String> {
    unsafe {
        let _result = i16x8_extadd_pairwise_i8x16(0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_extadd_pairwise_i8x16(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_extadd_pairwise_u8x16() -> Result<(), String> {
    unsafe {
        let _result = i16x8_extadd_pairwise_u8x16(0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_extadd_pairwise_u8x16(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_abs() -> Result<(), String> {
    unsafe {
        let _result = i16x8_abs(0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_abs(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_neg() -> Result<(), String> {
    unsafe {
        let _result = i16x8_neg(0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_neg(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_q15mulr_sat() -> Result<(), String> {
    unsafe {
        let _result = i16x8_q15mulr_sat(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_q15mulr_sat(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_all_true() -> Result<(), String> {
    unsafe {
        let _result = i16x8_all_true(0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_all_true(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_bitmask() -> Result<(), String> {
    unsafe {
        let result = i16x8_bitmask(0 /* v128 */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_bitmask(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_narrow_i32x4() -> Result<(), String> {
    unsafe {
        let _result = i16x8_narrow_i32x4(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_narrow_i32x4(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_u16x8_narrow_i32x4() -> Result<(), String> {
    unsafe {
        let _result = u16x8_narrow_i32x4(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u16x8_narrow_i32x4(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_extend_low_i8x16() -> Result<(), String> {
    unsafe {
        let _result = i16x8_extend_low_i8x16(0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_extend_low_i8x16(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_extend_high_i8x16() -> Result<(), String> {
    unsafe {
        let _result = i16x8_extend_high_i8x16(0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_extend_high_i8x16(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_extend_low_u8x16() -> Result<(), String> {
    unsafe {
        let _result = i16x8_extend_low_u8x16(0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_extend_low_u8x16(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_extend_high_u8x16() -> Result<(), String> {
    unsafe {
        let _result = i16x8_extend_high_u8x16(0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_extend_high_u8x16(0 /* v128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_shl() -> Result<(), String> {
    unsafe {
        let _result = i16x8_shl(0 /* v128 */, 1u32);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_shl(0 /* v128 */, rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_shr() -> Result<(), String> {
    unsafe {
        let _result = i16x8_shr(0 /* v128 */, 1u32);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_shr(0 /* v128 */, rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_u16x8_shr() -> Result<(), String> {
    unsafe {
        let _result = u16x8_shr(0 /* v128 */, 1u32);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = u16x8_shr(0 /* v128 */, rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_i16x8_add() -> Result<(), String> {
    unsafe {
        let _result = i16x8_add(0 /* v128 */, 0 /* v128 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = i16x8_add(0 /* v128 */, 0 /* v128 */);
            }
        }
    }
    Ok(())
}
