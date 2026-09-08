use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_loongarch64_generated_lsx_vstx() -> Result<(), String> {
    unsafe {
        let a = 0 /* m128i */;
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let b = 2i64;
        lsx_vstx(a, ptr_mem_addr.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vextl_qu_du() -> Result<(), String> {
    unsafe {
        let _result = lsx_vextl_qu_du(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vextl_qu_du(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_bnz_b() -> Result<(), String> {
    unsafe {
        let result = lsx_bnz_b(0 /* m128i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lsx_bnz_b(0 /* m128i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_bnz_b(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_bnz_d() -> Result<(), String> {
    unsafe {
        let result = lsx_bnz_d(0 /* m128i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lsx_bnz_d(0 /* m128i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_bnz_d(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_bnz_h() -> Result<(), String> {
    unsafe {
        let result = lsx_bnz_h(0 /* m128i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lsx_bnz_h(0 /* m128i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_bnz_h(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_bnz_v() -> Result<(), String> {
    unsafe {
        let result = lsx_bnz_v(0 /* m128i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lsx_bnz_v(0 /* m128i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_bnz_v(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_bnz_w() -> Result<(), String> {
    unsafe {
        let result = lsx_bnz_w(0 /* m128i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lsx_bnz_w(0 /* m128i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_bnz_w(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_bz_b() -> Result<(), String> {
    unsafe {
        let result = lsx_bz_b(0 /* m128i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lsx_bz_b(0 /* m128i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_bz_b(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_bz_d() -> Result<(), String> {
    unsafe {
        let result = lsx_bz_d(0 /* m128i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lsx_bz_d(0 /* m128i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_bz_d(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_bz_h() -> Result<(), String> {
    unsafe {
        let result = lsx_bz_h(0 /* m128i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lsx_bz_h(0 /* m128i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_bz_h(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_bz_v() -> Result<(), String> {
    unsafe {
        let result = lsx_bz_v(0 /* m128i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lsx_bz_v(0 /* m128i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_bz_v(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_bz_w() -> Result<(), String> {
    unsafe {
        let result = lsx_bz_w(0 /* m128i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lsx_bz_w(0 /* m128i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_bz_w(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_caf_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_caf_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_caf_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_caf_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_caf_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_caf_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_ceq_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_ceq_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_ceq_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_ceq_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_ceq_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_ceq_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_cle_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_cle_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_cle_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_cle_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_cle_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_cle_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_clt_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_clt_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_clt_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_clt_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_clt_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_clt_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_cne_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_cne_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_cne_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_cne_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_cne_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_cne_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_cor_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_cor_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_cor_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_cor_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_cor_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_cor_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_cueq_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_cueq_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_cueq_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_cueq_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_cueq_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_cueq_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_cule_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_cule_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_cule_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_cule_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_cule_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_cule_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_cult_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_cult_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_cult_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_cult_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_cult_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_cult_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_cun_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_cun_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_cun_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_cune_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_cune_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_cune_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_cune_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_cune_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_cune_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_cun_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_cun_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_cun_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_saf_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_saf_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_saf_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_saf_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_saf_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_saf_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_seq_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_seq_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_seq_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_seq_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_seq_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_seq_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_sle_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_sle_d(0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_sle_d(0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_sle_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfcmp_sle_s(0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfcmp_sle_s(0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfcmp_slt_d() -> Result<(), String> {
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

pub(super) fn test_loongarch64_generated_lsx_vfcmp_slt_s() -> Result<(), String> {
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

pub(super) fn test_loongarch64_generated_lsx_vfcmp_sne_d() -> Result<(), String> {
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

pub(super) fn test_loongarch64_generated_lsx_vfcmp_sne_s() -> Result<(), String> {
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

pub(super) fn test_loongarch64_generated_lsx_vfcmp_sor_d() -> Result<(), String> {
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

pub(super) fn test_loongarch64_generated_lsx_vfcmp_sor_s() -> Result<(), String> {
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

pub(super) fn test_loongarch64_generated_lsx_vfcmp_sueq_d() -> Result<(), String> {
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

pub(super) fn test_loongarch64_generated_lsx_vfcmp_sueq_s() -> Result<(), String> {
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

pub(super) fn test_loongarch64_generated_lsx_vfcmp_sule_d() -> Result<(), String> {
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

pub(super) fn test_loongarch64_generated_lsx_vfcmp_sule_s() -> Result<(), String> {
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
