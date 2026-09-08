use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_loongarch64_generated_lsx_vffinth_d_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vffinth_d_w(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vffinth_d_w(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vffintl_d_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vffintl_d_w(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vffintl_d_w(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vftintrzl_l_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vftintrzl_l_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vftintrzl_l_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vftintrzh_l_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vftintrzh_l_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vftintrzh_l_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vftintrpl_l_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vftintrpl_l_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vftintrpl_l_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vftintrph_l_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vftintrph_l_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vftintrph_l_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vftintrml_l_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vftintrml_l_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vftintrml_l_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vftintrmh_l_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vftintrmh_l_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vftintrmh_l_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vftintrnel_l_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vftintrnel_l_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vftintrnel_l_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vftintrneh_l_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vftintrneh_l_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vftintrneh_l_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfrintrne_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfrintrne_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfrintrne_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfrintrne_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfrintrne_d(0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfrintrne_d(0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfrintrz_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfrintrz_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfrintrz_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfrintrz_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfrintrz_d(0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfrintrz_d(0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfrintrp_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfrintrp_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfrintrp_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfrintrp_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfrintrp_d(0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfrintrp_d(0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfrintrm_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfrintrm_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfrintrm_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vfrintrm_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfrintrm_d(0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfrintrm_d(0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vstelm_b() -> Result<(), String> {
    unsafe {
        let a = 0 /* m128i */;
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        lsx_vstelm_b::<0, 0>(a, ptr_mem_addr.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vstelm_h() -> Result<(), String> {
    unsafe {
        let a = 0 /* m128i */;
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        lsx_vstelm_h::<0, 0>(a, ptr_mem_addr.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vstelm_w() -> Result<(), String> {
    unsafe {
        let a = 0 /* m128i */;
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        lsx_vstelm_w::<0, 0>(a, ptr_mem_addr.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vstelm_d() -> Result<(), String> {
    unsafe {
        let a = 0 /* m128i */;
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        lsx_vstelm_d::<0, 0>(a, ptr_mem_addr.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vaddwev_d_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vaddwev_d_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vaddwev_d_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vaddwev_w_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vaddwev_w_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vaddwev_w_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vaddwev_h_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vaddwev_h_b(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vaddwev_h_b(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vaddwod_d_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vaddwod_d_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vaddwod_d_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vaddwod_w_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vaddwod_w_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vaddwod_w_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vaddwod_h_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vaddwod_h_b(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vaddwod_h_b(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vaddwev_d_wu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vaddwev_d_wu(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vaddwev_d_wu(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vaddwev_w_hu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vaddwev_w_hu(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vaddwev_w_hu(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vaddwev_h_bu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vaddwev_h_bu(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vaddwev_h_bu(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vaddwod_d_wu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vaddwod_d_wu(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vaddwod_d_wu(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vaddwod_w_hu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vaddwod_w_hu(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vaddwod_w_hu(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vaddwod_h_bu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vaddwod_h_bu(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vaddwod_h_bu(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vaddwev_d_wu_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vaddwev_d_wu_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vaddwev_d_wu_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vaddwev_w_hu_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vaddwev_w_hu_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vaddwev_w_hu_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vaddwev_h_bu_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vaddwev_h_bu_b(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vaddwev_h_bu_b(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vaddwod_d_wu_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vaddwod_d_wu_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vaddwod_d_wu_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vaddwod_w_hu_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vaddwod_w_hu_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vaddwod_w_hu_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vaddwod_h_bu_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vaddwod_h_bu_b(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vaddwod_h_bu_b(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vsubwev_d_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsubwev_d_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsubwev_d_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vsubwev_w_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsubwev_w_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsubwev_w_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vsubwev_h_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsubwev_h_b(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsubwev_h_b(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vsubwod_d_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsubwod_d_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsubwod_d_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vsubwod_w_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsubwod_w_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsubwod_w_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vsubwod_h_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsubwod_h_b(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsubwod_h_b(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vsubwev_d_wu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsubwev_d_wu(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsubwev_d_wu(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vsubwev_w_hu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsubwev_w_hu(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsubwev_w_hu(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vsubwev_h_bu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsubwev_h_bu(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsubwev_h_bu(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lsx_vsubwod_d_wu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsubwod_d_wu(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsubwod_d_wu(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}
