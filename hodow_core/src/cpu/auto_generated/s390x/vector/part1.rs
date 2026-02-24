use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_va_float() -> Result<(), String> {
    unsafe {
        let _result = va_float(0 /* vector_float */, 0 /* vector_float */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vs_float() -> Result<(), String> {
    unsafe {
        let _result = vs_float(0 /* vector_float */, 0 /* vector_float */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_vsumqf() -> Result<(), String> {
    unsafe {
        let _result = vec_vsumqf(0 /* vector_unsigned_int */, 0 /* vector_unsigned_int */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_vsumqg() -> Result<(), String> {
    unsafe {
        let _result = vec_vsumqg(0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_long_long */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vcdgb() -> Result<(), String> {
    unsafe {
        let _result = vcdgb(0 /* vector_signed_long_long */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vcdlgb() -> Result<(), String> {
    unsafe {
        let _result = vcdlgb(0 /* vector_unsigned_long_long */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vcefb() -> Result<(), String> {
    unsafe {
        let _result = vcefb(0 /* vector_signed_int */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vcelfb() -> Result<(), String> {
    unsafe {
        let _result = vcelfb(0 /* vector_unsigned_int */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vsegb() -> Result<(), String> {
    unsafe {
        let _result = vsegb(0 /* vector_signed_char */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vsegh() -> Result<(), String> {
    unsafe {
        let _result = vsegh(0 /* vector_signed_short */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vsegf() -> Result<(), String> {
    unsafe {
        let _result = vsegf(0 /* vector_signed_int */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_add() -> Result<(), String> {
    unsafe {
        let _result = vec_add(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_sub() -> Result<(), String> {
    unsafe {
        let _result = vec_sub(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_mul() -> Result<(), String> {
    unsafe {
        let _result = vec_mul(0 /* T */, 0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_cntlz() -> Result<(), String> {
    unsafe {
        let _result = vec_cntlz(0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_cnttz() -> Result<(), String> {
    unsafe {
        let _result = vec_cnttz(0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_popcnt() -> Result<(), String> {
    unsafe {
        let _result = vec_popcnt(0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_max() -> Result<(), String> {
    unsafe {
        let _result = vec_max(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_min() -> Result<(), String> {
    unsafe {
        let _result = vec_min(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_abs() -> Result<(), String> {
    unsafe {
        let _result = vec_abs(0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_nabs() -> Result<(), String> {
    unsafe {
        let _result = vec_nabs(0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_nmadd() -> Result<(), String> {
    unsafe {
        let _result = vec_nmadd(0 /* T */, 0 /* T */, 0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_nmsub() -> Result<(), String> {
    unsafe {
        let _result = vec_nmsub(0 /* T */, 0 /* T */, 0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_sqrt() -> Result<(), String> {
    unsafe {
        let _result = vec_sqrt(0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_splat() -> Result<(), String> {
    unsafe {
        let _result = vec_splat::<0>(0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_splats() -> Result<(), String> {
    unsafe {
        let _result = vec_splats(0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_and() -> Result<(), String> {
    unsafe {
        let _result = vec_and(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_or() -> Result<(), String> {
    unsafe {
        let _result = vec_or(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_xor() -> Result<(), String> {
    unsafe {
        let _result = vec_xor(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_nor() -> Result<(), String> {
    unsafe {
        let _result = vec_nor(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_nand() -> Result<(), String> {
    unsafe {
        let _result = vec_nand(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_eqv() -> Result<(), String> {
    unsafe {
        let _result = vec_eqv(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_andc() -> Result<(), String> {
    unsafe {
        let _result = vec_andc(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_orc() -> Result<(), String> {
    unsafe {
        let _result = vec_orc(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_floor() -> Result<(), String> {
    unsafe {
        let _result = vec_floor(0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_ceil() -> Result<(), String> {
    unsafe {
        let _result = vec_ceil(0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_trunc() -> Result<(), String> {
    unsafe {
        let _result = vec_trunc(0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_round() -> Result<(), String> {
    unsafe {
        let _result = vec_round(0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_roundc() -> Result<(), String> {
    unsafe {
        let _result = vec_roundc(0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_roundm() -> Result<(), String> {
    unsafe {
        let _result = vec_roundm(0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_roundp() -> Result<(), String> {
    unsafe {
        let _result = vec_roundp(0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_roundz() -> Result<(), String> {
    unsafe {
        let _result = vec_roundz(0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_rint() -> Result<(), String> {
    unsafe {
        let _result = vec_rint(0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_avg() -> Result<(), String> {
    unsafe {
        let _result = vec_avg(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_sl() -> Result<(), String> {
    unsafe {
        let _result = vec_sl(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_sr() -> Result<(), String> {
    unsafe {
        let _result = vec_sr(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_sra() -> Result<(), String> {
    unsafe {
        let _result = vec_sra(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_slb() -> Result<(), String> {
    unsafe {
        let _result = vec_slb(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_srb() -> Result<(), String> {
    unsafe {
        let _result = vec_srb(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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

pub(super) fn test_vec_srab() -> Result<(), String> {
    unsafe {
        let _result = vec_srab(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
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
