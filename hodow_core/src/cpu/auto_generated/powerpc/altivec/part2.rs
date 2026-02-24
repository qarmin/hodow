use std::arch::powerpc::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_vec_cmpeq() -> Result<(), String> {
    unsafe {
        vec_cmpeq(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cmpeq(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_cmpne() -> Result<(), String> {
    unsafe {
        vec_cmpne(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cmpne(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_cmpb() -> Result<(), String> {
    unsafe {
        let _result = vec_cmpb(0 /* vector_float */, 0 /* vector_float */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cmpb(0 /* vector_float */, 0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_ceil() -> Result<(), String> {
    unsafe {
        let _result = vec_ceil(0 /* vector_float */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_ceil(0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_avg() -> Result<(), String> {
    unsafe {
        vec_avg(0 /* T */, 0 /* U */);

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

pub(super) fn test_vec_andc() -> Result<(), String> {
    unsafe {
        vec_andc(0 /* T */, 0 /* U */);

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
        vec_orc(0 /* T */, 0 /* U */);

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

pub(super) fn test_vec_and() -> Result<(), String> {
    unsafe {
        vec_and(0 /* T */, 0 /* U */);

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
        vec_or(0 /* T */, 0 /* U */);

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

pub(super) fn test_vec_nand() -> Result<(), String> {
    unsafe {
        vec_nand(0 /* T */, 0 /* U */);

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

pub(super) fn test_vec_nor() -> Result<(), String> {
    unsafe {
        vec_nor(0 /* T */, 0 /* U */);

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

pub(super) fn test_vec_xor() -> Result<(), String> {
    unsafe {
        vec_xor(0 /* T */, 0 /* U */);

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

pub(super) fn test_vec_adds() -> Result<(), String> {
    unsafe {
        vec_adds(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_adds(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_addc() -> Result<(), String> {
    unsafe {
        let _result = vec_addc(0 /* vector_unsigned_int */, 0 /* vector_unsigned_int */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_addc(0 /* vector_unsigned_int */, 0 /* vector_unsigned_int */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_abs() -> Result<(), String> {
    unsafe {
        vec_abs(0 /* T */);

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

pub(super) fn test_vec_abss() -> Result<(), String> {
    unsafe {
        vec_abss(0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_abss(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_rl() -> Result<(), String> {
    unsafe {
        vec_rl(0 /* T */, 0 /* Shift */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_rl(0 /* T */, 0 /* Shift */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_round() -> Result<(), String> {
    unsafe {
        vec_round(0 /* T */);

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

pub(super) fn test_vec_splat() -> Result<(), String> {
    unsafe {
        vec_splat::<0>(0 /* T */);

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
        vec_splats(0 /* T */);

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

pub(super) fn test_vec_sub() -> Result<(), String> {
    unsafe {
        vec_sub(0 /* T */, 0 /* U */);

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

pub(super) fn test_vec_subc() -> Result<(), String> {
    unsafe {
        vec_subc(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_subc(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_subs() -> Result<(), String> {
    unsafe {
        vec_subs(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_subs(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_min() -> Result<(), String> {
    unsafe {
        vec_min(0 /* T */, 0 /* U */);

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

pub(super) fn test_vec_max() -> Result<(), String> {
    unsafe {
        vec_max(0 /* T */, 0 /* U */);

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

pub(super) fn test_vec_mfvscr() -> Result<(), String> {
    unsafe {
        let _result = vec_mfvscr();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_mfvscr();
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_add() -> Result<(), String> {
    unsafe {
        vec_add(0 /* T */, 0 /* U */);

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

pub(super) fn test_vec_adde() -> Result<(), String> {
    unsafe {
        vec_adde(0 /* T */, 0 /* T */, 0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_adde(0 /* T */, 0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_ctf() -> Result<(), String> {
    unsafe {
        vec_ctf::<0>(0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_ctf::<0>(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_cts() -> Result<(), String> {
    unsafe {
        let _result = vec_cts::<0>(0 /* vector_float */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cts::<0>(0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_ctu() -> Result<(), String> {
    unsafe {
        let _result = vec_ctu::<0>(0 /* vector_float */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_ctu::<0>(0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_perm() -> Result<(), String> {
    unsafe {
        vec_perm(0 /* T */, 0 /* T */, 0 /* vector_unsigned_char */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_perm(0 /* T */, 0 /* T */, 0 /* vector_unsigned_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_sum2s() -> Result<(), String> {
    unsafe {
        let _result = vec_sum2s(0 /* vector_signed_int */, 0 /* vector_signed_int */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_sum2s(0 /* vector_signed_int */, 0 /* vector_signed_int */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_mule() -> Result<(), String> {
    unsafe {
        vec_mule(0 /* T */, 0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_mule(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_mulo() -> Result<(), String> {
    unsafe {
        vec_mulo(0 /* T */, 0 /* T */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_mulo(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_mul() -> Result<(), String> {
    unsafe {
        vec_mul(0 /* T */, 0 /* T */);

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

pub(super) fn test_vec_madds() -> Result<(), String> {
    unsafe {
        let _result = vec_madds(0 /* vector_signed_short */, 0 /* vector_signed_short */, 0 /* vector_signed_short */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_madds(0 /* vector_signed_short */, 0 /* vector_signed_short */, 0 /* vector_signed_short */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_mladd() -> Result<(), String> {
    unsafe {
        vec_mladd(0 /* T */, 0 /* U */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_mladd(0 /* T */, 0 /* U */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_mradds() -> Result<(), String> {
    unsafe {
        let _result = vec_mradds(0 /* vector_signed_short */, 0 /* vector_signed_short */, 0 /* vector_signed_short */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_mradds(0 /* vector_signed_short */, 0 /* vector_signed_short */, 0 /* vector_signed_short */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_msum() -> Result<(), String> {
    unsafe {
        vec_msum(0 /* T */, 0 /* B */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_msum(0 /* T */, 0 /* B */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_msums() -> Result<(), String> {
    unsafe {
        vec_msums(0 /* T */, 0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_msums(0 /* T */, 0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_madd() -> Result<(), String> {
    unsafe {
        let _result = vec_madd(0 /* vector_float */, 0 /* vector_float */, 0 /* vector_float */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_madd(0 /* vector_float */, 0 /* vector_float */, 0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_nmsub() -> Result<(), String> {
    unsafe {
        let _result = vec_nmsub(0 /* vector_float */, 0 /* vector_float */, 0 /* vector_float */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_nmsub(0 /* vector_float */, 0 /* vector_float */, 0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_sel() -> Result<(), String> {
    unsafe {
        vec_sel(0 /* T */, 0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_sel(0 /* T */, 0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_sum4s() -> Result<(), String> {
    unsafe {
        vec_sum4s(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_sum4s(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_all_eq() -> Result<(), String> {
    unsafe {
        vec_all_eq(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_all_eq(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_any_eq() -> Result<(), String> {
    unsafe {
        vec_any_eq(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_any_eq(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_all_ge() -> Result<(), String> {
    unsafe {
        vec_all_ge(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_all_ge(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_any_ge() -> Result<(), String> {
    unsafe {
        vec_any_ge(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_any_ge(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_all_gt() -> Result<(), String> {
    unsafe {
        vec_all_gt(0 /* T */, 0 /* U */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_all_gt(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}
