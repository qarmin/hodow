use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_slt_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_slt_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_slt_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_slt_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_slt_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_slt_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sne_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_sne_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_sne_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sne_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_sne_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_sne_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sor_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_sor_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_sor_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sor_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_sor_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_sor_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sueq_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_sueq_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_sueq_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sueq_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_sueq_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_sueq_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sule_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_sule_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_sule_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sule_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_sule_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_sule_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sult_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_sult_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_sult_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sult_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_sult_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_sult_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sun_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_sun_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_sun_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sune_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_sune_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_sune_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sune_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_sune_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_sune_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfcmp_sun_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_sun_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_sun_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vrepli_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vrepli_b::<0>();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vrepli_b::<0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vrepli_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vrepli_d::<0>();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vrepli_d::<0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vrepli_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vrepli_h::<0>();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vrepli_h::<0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vrepli_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vrepli_w::<0>();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vrepli_w::<0>();
            }
        }
    }
    Ok(())
}
