use std::arch::mips::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mips_msa_msa_fsaf_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fsaf_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fsaf_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fseq_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fseq_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fseq_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fseq_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fseq_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fseq_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fsle_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fsle_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fsle_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fsle_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fsle_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fsle_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fslt_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fslt_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fslt_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fslt_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fslt_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fslt_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fsne_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fsne_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fsne_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fsne_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fsne_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fsne_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fsor_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fsor_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fsor_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fsor_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fsor_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fsor_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fsqrt_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fsqrt_w(0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fsqrt_w(0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fsqrt_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fsqrt_d(0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fsqrt_d(0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fsub_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fsub_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fsub_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fsub_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fsub_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fsub_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fsueq_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fsueq_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fsueq_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fsueq_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fsueq_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fsueq_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fsule_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fsule_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fsule_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fsule_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fsule_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fsule_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fsult_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fsult_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fsult_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fsult_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fsult_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fsult_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fsun_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fsun_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fsun_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fsun_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fsun_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fsun_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fsune_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fsune_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fsune_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fsune_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fsune_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fsune_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ftint_s_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_ftint_s_w(0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ftint_s_w(0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ftint_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_ftint_s_d(0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ftint_s_d(0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ftint_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_ftint_u_w(0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ftint_u_w(0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ftint_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_ftint_u_d(0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ftint_u_d(0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ftq_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_ftq_h(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ftq_h(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ftq_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_ftq_w(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ftq_w(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ftrunc_s_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_ftrunc_s_w(0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ftrunc_s_w(0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ftrunc_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_ftrunc_s_d(0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ftrunc_s_d(0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ftrunc_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_ftrunc_u_w(0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ftrunc_u_w(0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ftrunc_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_ftrunc_u_d(0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ftrunc_u_d(0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_hadd_s_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_hadd_s_h(0 /* v16i8 */, 0 /* v16i8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_hadd_s_h(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_hadd_s_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_hadd_s_w(0 /* v8i16 */, 0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_hadd_s_w(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_hadd_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_hadd_s_d(0 /* v4i32 */, 0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_hadd_s_d(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_hadd_u_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_hadd_u_h(0 /* v16u8 */, 0 /* v16u8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_hadd_u_h(0 /* v16u8 */, 0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_hadd_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_hadd_u_w(0 /* v8u16 */, 0 /* v8u16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_hadd_u_w(0 /* v8u16 */, 0 /* v8u16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_hadd_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_hadd_u_d(0 /* v4u32 */, 0 /* v4u32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_hadd_u_d(0 /* v4u32 */, 0 /* v4u32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_hsub_s_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_hsub_s_h(0 /* v16i8 */, 0 /* v16i8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_hsub_s_h(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_hsub_s_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_hsub_s_w(0 /* v8i16 */, 0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_hsub_s_w(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_hsub_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_hsub_s_d(0 /* v4i32 */, 0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_hsub_s_d(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_hsub_u_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_hsub_u_h(0 /* v16u8 */, 0 /* v16u8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_hsub_u_h(0 /* v16u8 */, 0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_hsub_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_hsub_u_w(0 /* v8u16 */, 0 /* v8u16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_hsub_u_w(0 /* v8u16 */, 0 /* v8u16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_hsub_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_hsub_u_d(0 /* v4u32 */, 0 /* v4u32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_hsub_u_d(0 /* v4u32 */, 0 /* v4u32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ilvev_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_ilvev_b(0 /* v16i8 */, 0 /* v16i8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ilvev_b(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ilvev_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_ilvev_h(0 /* v8i16 */, 0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ilvev_h(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ilvev_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_ilvev_w(0 /* v4i32 */, 0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ilvev_w(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}
