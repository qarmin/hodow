use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_loongarch64_generated_lasx_xvffinth_d_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvffinth_d_w(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvffinth_d_w(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvffintl_d_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvffintl_d_w(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvffintl_d_w(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvftintrzh_l_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvftintrzh_l_s(0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvftintrzh_l_s(0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvftintrzl_l_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvftintrzl_l_s(0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvftintrzl_l_s(0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvftintrph_l_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvftintrph_l_s(0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvftintrph_l_s(0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvftintrpl_l_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvftintrpl_l_s(0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvftintrpl_l_s(0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvftintrmh_l_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvftintrmh_l_s(0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvftintrmh_l_s(0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvftintrml_l_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvftintrml_l_s(0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvftintrml_l_s(0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvftintrneh_l_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvftintrneh_l_s(0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvftintrneh_l_s(0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvftintrnel_l_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvftintrnel_l_s(0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvftintrnel_l_s(0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvfrintrne_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfrintrne_s(0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfrintrne_s(0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvfrintrne_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfrintrne_d(0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfrintrne_d(0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvfrintrz_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfrintrz_s(0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfrintrz_s(0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvfrintrz_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfrintrz_d(0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfrintrz_d(0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvfrintrp_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfrintrp_s(0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfrintrp_s(0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvfrintrp_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfrintrp_d(0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfrintrp_d(0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvfrintrm_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfrintrm_s(0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfrintrm_s(0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvfrintrm_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfrintrm_d(0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfrintrm_d(0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvld() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let _result = lasx_xvld::<0>(ptr_mem_addr.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvst() -> Result<(), String> {
    unsafe {
        let a = 0 /* m256i */;
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        lasx_xvst::<0>(a, ptr_mem_addr.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvstelm_b() -> Result<(), String> {
    unsafe {
        let a = 0 /* m256i */;
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        lasx_xvstelm_b::<0, 0>(a, ptr_mem_addr.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvstelm_h() -> Result<(), String> {
    unsafe {
        let a = 0 /* m256i */;
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        lasx_xvstelm_h::<0, 0>(a, ptr_mem_addr.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvstelm_w() -> Result<(), String> {
    unsafe {
        let a = 0 /* m256i */;
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        lasx_xvstelm_w::<0, 0>(a, ptr_mem_addr.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvstelm_d() -> Result<(), String> {
    unsafe {
        let a = 0 /* m256i */;
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        lasx_xvstelm_d::<0, 0>(a, ptr_mem_addr.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvinsve0_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvinsve0_w::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvinsve0_w::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvinsve0_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvinsve0_d::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvinsve0_d::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvpickve_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvpickve_w::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvpickve_w::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvpickve_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvpickve_d::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvpickve_d::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvssrlrn_b_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrlrn_b_h(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrlrn_b_h(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvssrlrn_h_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrlrn_h_w(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrlrn_h_w(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvssrlrn_w_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrlrn_w_d(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrlrn_w_d(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvssrln_b_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrln_b_h(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrln_b_h(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvssrln_h_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrln_h_w(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrln_h_w(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvssrln_w_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrln_w_d(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrln_w_d(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvorn_v() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvorn_v(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvorn_v(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvldi() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvldi::<0>();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvldi::<0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvldx() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let b = 2i64;
        let _result = lasx_xvldx(ptr_mem_addr.0.as_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvstx() -> Result<(), String> {
    unsafe {
        let a = 0 /* m256i */;
        let mut ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let b = 2i64;
        lasx_xvstx(a, ptr_mem_addr.0.as_mut_ptr(), b);
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvextl_qu_du() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvextl_qu_du(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvextl_qu_du(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvinsgr2vr_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvinsgr2vr_w::<0>(0 /* m256i */, 1i32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvinsgr2vr_w::<0>(0 /* m256i */, rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvinsgr2vr_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvinsgr2vr_d::<0>(0 /* m256i */, 1i64);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvinsgr2vr_d::<0>(0 /* m256i */, rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvreplve0_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvreplve0_b(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvreplve0_b(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvreplve0_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvreplve0_h(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvreplve0_h(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvreplve0_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvreplve0_w(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvreplve0_w(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvreplve0_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvreplve0_d(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvreplve0_d(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvreplve0_q() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvreplve0_q(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvreplve0_q(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_vext2xv_h_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_vext2xv_h_b(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_vext2xv_h_b(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_vext2xv_w_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_vext2xv_w_h(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_vext2xv_w_h(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_vext2xv_d_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_vext2xv_d_w(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_vext2xv_d_w(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_vext2xv_w_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_vext2xv_w_b(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_vext2xv_w_b(0 /* m256i */);
            }
        }
    }
    Ok(())
}
