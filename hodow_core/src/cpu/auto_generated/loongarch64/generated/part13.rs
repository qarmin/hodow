use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_loongarch64_generated_lasx_xvmaddwev_d_wu_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmaddwev_d_wu_w(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmaddwev_d_wu_w(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvmaddwev_w_hu_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmaddwev_w_hu_h(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmaddwev_w_hu_h(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvmaddwev_h_bu_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmaddwev_h_bu_b(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmaddwev_h_bu_b(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvmaddwod_q_du_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmaddwod_q_du_d(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmaddwod_q_du_d(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvmaddwod_d_wu_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmaddwod_d_wu_w(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmaddwod_d_wu_w(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvmaddwod_w_hu_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmaddwod_w_hu_h(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmaddwod_w_hu_h(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvmaddwod_h_bu_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmaddwod_h_bu_b(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmaddwod_h_bu_b(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvrotr_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvrotr_b(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvrotr_b(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvrotr_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvrotr_h(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvrotr_h(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvrotr_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvrotr_w(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvrotr_w(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvrotr_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvrotr_d(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvrotr_d(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvadd_q() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvadd_q(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvadd_q(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvsub_q() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsub_q(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsub_q(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvaddwev_q_du_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvaddwev_q_du_d(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvaddwev_q_du_d(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvaddwod_q_du_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvaddwod_q_du_d(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvaddwod_q_du_d(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvmulwev_q_du_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmulwev_q_du_d(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmulwev_q_du_d(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvmulwod_q_du_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmulwod_q_du_d(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmulwod_q_du_d(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvmskgez_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmskgez_b(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmskgez_b(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvmsknz_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmsknz_b(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmsknz_b(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvexth_h_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvexth_h_b(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvexth_h_b(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvexth_w_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvexth_w_h(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvexth_w_h(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvexth_d_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvexth_d_w(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvexth_d_w(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvexth_q_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvexth_q_d(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvexth_q_d(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvexth_hu_bu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvexth_hu_bu(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvexth_hu_bu(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvexth_wu_hu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvexth_wu_hu(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvexth_wu_hu(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvexth_du_wu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvexth_du_wu(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvexth_du_wu(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvexth_qu_du() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvexth_qu_du(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvexth_qu_du(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvrotri_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvrotri_b::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvrotri_b::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvrotri_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvrotri_h::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvrotri_h::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvrotri_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvrotri_w::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvrotri_w::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvrotri_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvrotri_d::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvrotri_d::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvextl_q_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvextl_q_d(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvextl_q_d(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvsrlni_b_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrlni_b_h::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrlni_b_h::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvsrlni_h_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrlni_h_w::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrlni_h_w::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvsrlni_w_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrlni_w_d::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrlni_w_d::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvsrlni_d_q() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrlni_d_q::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrlni_d_q::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvsrlrni_b_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrlrni_b_h::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrlrni_b_h::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvsrlrni_h_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrlrni_h_w::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrlrni_h_w::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvsrlrni_w_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrlrni_w_d::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrlrni_w_d::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvsrlrni_d_q() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrlrni_d_q::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrlrni_d_q::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvssrlni_b_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrlni_b_h::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrlni_b_h::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvssrlni_h_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrlni_h_w::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrlni_h_w::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvssrlni_w_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrlni_w_d::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrlni_w_d::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvssrlni_d_q() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrlni_d_q::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrlni_d_q::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvssrlni_bu_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrlni_bu_h::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrlni_bu_h::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvssrlni_hu_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrlni_hu_w::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrlni_hu_w::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvssrlni_wu_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrlni_wu_d::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrlni_wu_d::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvssrlni_du_q() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrlni_du_q::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrlni_du_q::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvssrlrni_b_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrlrni_b_h::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrlrni_b_h::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvssrlrni_h_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrlrni_h_w::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrlrni_h_w::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}
