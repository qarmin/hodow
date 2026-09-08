use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cor_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_cor_d(0 /* m256d */, 0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_cor_d(0 /* m256d */, 0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cor_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_cor_s(0 /* m256 */, 0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_cor_s(0 /* m256 */, 0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cueq_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_cueq_d(0 /* m256d */, 0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_cueq_d(0 /* m256d */, 0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cueq_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_cueq_s(0 /* m256 */, 0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_cueq_s(0 /* m256 */, 0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cule_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_cule_d(0 /* m256d */, 0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_cule_d(0 /* m256d */, 0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cule_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_cule_s(0 /* m256 */, 0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_cule_s(0 /* m256 */, 0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cult_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_cult_d(0 /* m256d */, 0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_cult_d(0 /* m256d */, 0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cult_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_cult_s(0 /* m256 */, 0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_cult_s(0 /* m256 */, 0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cun_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_cun_d(0 /* m256d */, 0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_cun_d(0 /* m256d */, 0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cune_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_cune_d(0 /* m256d */, 0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_cune_d(0 /* m256d */, 0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cune_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_cune_s(0 /* m256 */, 0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_cune_s(0 /* m256 */, 0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cun_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_cun_s(0 /* m256 */, 0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_cun_s(0 /* m256 */, 0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_saf_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_saf_d(0 /* m256d */, 0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_saf_d(0 /* m256d */, 0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_saf_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_saf_s(0 /* m256 */, 0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_saf_s(0 /* m256 */, 0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_seq_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_seq_d(0 /* m256d */, 0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_seq_d(0 /* m256d */, 0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_seq_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_seq_s(0 /* m256 */, 0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_seq_s(0 /* m256 */, 0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sle_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_sle_d(0 /* m256d */, 0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_sle_d(0 /* m256d */, 0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sle_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_sle_s(0 /* m256 */, 0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_sle_s(0 /* m256 */, 0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_slt_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_slt_d(0 /* m256d */, 0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_slt_d(0 /* m256d */, 0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_slt_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_slt_s(0 /* m256 */, 0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_slt_s(0 /* m256 */, 0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sne_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_sne_d(0 /* m256d */, 0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_sne_d(0 /* m256d */, 0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sne_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_sne_s(0 /* m256 */, 0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_sne_s(0 /* m256 */, 0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sor_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_sor_d(0 /* m256d */, 0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_sor_d(0 /* m256d */, 0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sor_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_sor_s(0 /* m256 */, 0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_sor_s(0 /* m256 */, 0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sueq_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_sueq_d(0 /* m256d */, 0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_sueq_d(0 /* m256d */, 0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sueq_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_sueq_s(0 /* m256 */, 0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_sueq_s(0 /* m256 */, 0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sule_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_sule_d(0 /* m256d */, 0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_sule_d(0 /* m256d */, 0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sule_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_sule_s(0 /* m256 */, 0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_sule_s(0 /* m256 */, 0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sult_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_sult_d(0 /* m256d */, 0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_sult_d(0 /* m256d */, 0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sult_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_sult_s(0 /* m256 */, 0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_sult_s(0 /* m256 */, 0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sun_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_sun_d(0 /* m256d */, 0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_sun_d(0 /* m256d */, 0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sune_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_sune_d(0 /* m256d */, 0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_sune_d(0 /* m256d */, 0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sune_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_sune_s(0 /* m256 */, 0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_sune_s(0 /* m256 */, 0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_sun_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_sun_s(0 /* m256 */, 0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_sun_s(0 /* m256 */, 0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvpickve_d_f() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvpickve_d_f::<0>(0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvpickve_d_f::<0>(0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvpickve_w_f() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvpickve_w_f::<0>(0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvpickve_w_f::<0>(0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvrepli_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvrepli_b::<0>();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvrepli_b::<0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvrepli_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvrepli_d::<0>();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvrepli_d::<0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvrepli_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvrepli_h::<0>();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvrepli_h::<0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvrepli_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvrepli_w::<0>();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvrepli_w::<0>();
            }
        }
    }
    Ok(())
}
