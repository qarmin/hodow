use std::arch::mips::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mips_msa_msa_fcule_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fcule_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fcule_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fcule_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fcule_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fcule_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fcult_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fcult_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fcult_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fcult_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fcult_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fcult_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fcun_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fcun_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fcun_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fcun_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fcun_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fcun_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fcune_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fcune_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fcune_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fcune_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fcune_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fcune_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fdiv_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fdiv_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fdiv_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fdiv_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fdiv_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fdiv_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fexdo_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fexdo_w(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fexdo_w(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fexp2_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fexp2_w(0 /* v4f32 */, 0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fexp2_w(0 /* v4f32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fexp2_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fexp2_d(0 /* v2f64 */, 0 /* v2i64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fexp2_d(0 /* v2f64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fexupl_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fexupl_d(0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fexupl_d(0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fexupr_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fexupr_d(0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fexupr_d(0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ffint_s_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_ffint_s_w(0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ffint_s_w(0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ffint_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_ffint_s_d(0 /* v2i64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ffint_s_d(0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ffint_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_ffint_u_w(0 /* v4u32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ffint_u_w(0 /* v4u32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ffint_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_ffint_u_d(0 /* v2u64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ffint_u_d(0 /* v2u64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ffql_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_ffql_w(0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ffql_w(0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ffql_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_ffql_d(0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ffql_d(0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ffqr_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_ffqr_w(0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ffqr_w(0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ffqr_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_ffqr_d(0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ffqr_d(0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fill_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_fill_b(1i32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fill_b(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fill_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_fill_h(1i32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fill_h(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fill_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fill_w(1i32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fill_w(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fill_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fill_d(1i64);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fill_d(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_flog2_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_flog2_w(0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_flog2_w(0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_flog2_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_flog2_d(0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_flog2_d(0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fmadd_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fmadd_w(0 /* v4f32 */, 0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fmadd_w(0 /* v4f32 */, 0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fmadd_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fmadd_d(0 /* v2f64 */, 0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fmadd_d(0 /* v2f64 */, 0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fmax_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fmax_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fmax_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fmax_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fmax_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fmax_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fmax_a_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fmax_a_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fmax_a_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fmax_a_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fmax_a_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fmax_a_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fmin_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fmin_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fmin_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fmin_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fmin_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fmin_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fmin_a_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fmin_a_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fmin_a_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fmin_a_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fmin_a_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fmin_a_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fmsub_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fmsub_w(0 /* v4f32 */, 0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fmsub_w(0 /* v4f32 */, 0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fmsub_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fmsub_d(0 /* v2f64 */, 0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fmsub_d(0 /* v2f64 */, 0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fmul_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fmul_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fmul_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fmul_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fmul_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fmul_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_frint_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_frint_w(0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_frint_w(0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_frint_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_frint_d(0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_frint_d(0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_frcp_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_frcp_w(0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_frcp_w(0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_frcp_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_frcp_d(0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_frcp_d(0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_frsqrt_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_frsqrt_w(0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_frsqrt_w(0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_frsqrt_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_frsqrt_d(0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_frsqrt_d(0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fsaf_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fsaf_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fsaf_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}
