use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_s390x_vector_va_float() -> Result<(), String> {
    unsafe {
        let _result = va_float(0 /* vector_float */, 0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = va_float(0 /* vector_float */, 0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vs_float() -> Result<(), String> {
    unsafe {
        let _result = vs_float(0 /* vector_float */, 0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vs_float(0 /* vector_float */, 0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_vsumqf() -> Result<(), String> {
    unsafe {
        let _result = vec_vsumqf(0 /* vector_unsigned_int */, 0 /* vector_unsigned_int */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_vsumqf(0 /* vector_unsigned_int */, 0 /* vector_unsigned_int */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_vsumqg() -> Result<(), String> {
    unsafe {
        let _result = vec_vsumqg(0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_long_long */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_vsumqg(0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_long_long */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vcdgb() -> Result<(), String> {
    unsafe {
        let _result = vcdgb(0 /* vector_signed_long_long */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcdgb(0 /* vector_signed_long_long */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vcdlgb() -> Result<(), String> {
    unsafe {
        let _result = vcdlgb(0 /* vector_unsigned_long_long */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcdlgb(0 /* vector_unsigned_long_long */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vcefb() -> Result<(), String> {
    unsafe {
        let _result = vcefb(0 /* vector_signed_int */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcefb(0 /* vector_signed_int */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vcelfb() -> Result<(), String> {
    unsafe {
        let _result = vcelfb(0 /* vector_unsigned_int */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vcelfb(0 /* vector_unsigned_int */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vsegb() -> Result<(), String> {
    unsafe {
        let _result = vsegb(0 /* vector_signed_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsegb(0 /* vector_signed_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vsegh() -> Result<(), String> {
    unsafe {
        let _result = vsegh(0 /* vector_signed_short */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsegh(0 /* vector_signed_short */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vsegf() -> Result<(), String> {
    unsafe {
        let _result = vsegf(0 /* vector_signed_int */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vsegf(0 /* vector_signed_int */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_add() -> Result<(), String> {
    unsafe {
        let _result = vec_add(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_add(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_sub() -> Result<(), String> {
    unsafe {
        let _result = vec_sub(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_sub(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_mul() -> Result<(), String> {
    unsafe {
        let _result = vec_mul(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_mul(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cntlz() -> Result<(), String> {
    unsafe {
        let _result = vec_cntlz(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cntlz(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cnttz() -> Result<(), String> {
    unsafe {
        let _result = vec_cnttz(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cnttz(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_popcnt() -> Result<(), String> {
    unsafe {
        let _result = vec_popcnt(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_popcnt(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_max() -> Result<(), String> {
    unsafe {
        let _result = vec_max(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_max(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_min() -> Result<(), String> {
    unsafe {
        let _result = vec_min(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_min(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_abs() -> Result<(), String> {
    unsafe {
        let _result = vec_abs(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_abs(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_nabs() -> Result<(), String> {
    unsafe {
        let _result = vec_nabs(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_nabs(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_nmadd() -> Result<(), String> {
    unsafe {
        let _result = vec_nmadd(0 /* T */, 0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_nmadd(0 /* T */, 0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_nmsub() -> Result<(), String> {
    unsafe {
        let _result = vec_nmsub(0 /* T */, 0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_nmsub(0 /* T */, 0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_sqrt() -> Result<(), String> {
    unsafe {
        let _result = vec_sqrt(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_sqrt(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_splat() -> Result<(), String> {
    unsafe {
        let _result = vec_splat::<0>(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_splat::<0>(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_splats() -> Result<(), String> {
    unsafe {
        let _result = vec_splats(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_splats(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_and() -> Result<(), String> {
    unsafe {
        let _result = vec_and(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_and(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_or() -> Result<(), String> {
    unsafe {
        let _result = vec_or(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_or(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_xor() -> Result<(), String> {
    unsafe {
        let _result = vec_xor(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_xor(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_nor() -> Result<(), String> {
    unsafe {
        let _result = vec_nor(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_nor(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_nand() -> Result<(), String> {
    unsafe {
        let _result = vec_nand(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_nand(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_eqv() -> Result<(), String> {
    unsafe {
        let _result = vec_eqv(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_eqv(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_andc() -> Result<(), String> {
    unsafe {
        let _result = vec_andc(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_andc(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_orc() -> Result<(), String> {
    unsafe {
        let _result = vec_orc(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_orc(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_floor() -> Result<(), String> {
    unsafe {
        let _result = vec_floor(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_floor(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_ceil() -> Result<(), String> {
    unsafe {
        let _result = vec_ceil(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_ceil(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_trunc() -> Result<(), String> {
    unsafe {
        let _result = vec_trunc(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_trunc(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_round() -> Result<(), String> {
    unsafe {
        let _result = vec_round(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_round(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_roundc() -> Result<(), String> {
    unsafe {
        let _result = vec_roundc(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_roundc(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_roundm() -> Result<(), String> {
    unsafe {
        let _result = vec_roundm(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_roundm(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_roundp() -> Result<(), String> {
    unsafe {
        let _result = vec_roundp(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_roundp(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_roundz() -> Result<(), String> {
    unsafe {
        let _result = vec_roundz(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_roundz(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_rint() -> Result<(), String> {
    unsafe {
        let _result = vec_rint(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_rint(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_avg() -> Result<(), String> {
    unsafe {
        let _result = vec_avg(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_avg(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_sl() -> Result<(), String> {
    unsafe {
        let _result = vec_sl(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_sl(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_sr() -> Result<(), String> {
    unsafe {
        let _result = vec_sr(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_sr(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_sra() -> Result<(), String> {
    unsafe {
        let _result = vec_sra(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_sra(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_slb() -> Result<(), String> {
    unsafe {
        let _result = vec_slb(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_slb(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_srb() -> Result<(), String> {
    unsafe {
        let _result = vec_srb(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_srb(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_srab() -> Result<(), String> {
    unsafe {
        let _result = vec_srab(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_srab(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}
