use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_loongarch64_lasx_lasx_xvabsd_bu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvabsd_bu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvabsd_bu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvabsd_hu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvabsd_hu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvabsd_hu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvabsd_wu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvabsd_wu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvabsd_wu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvabsd_du() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvabsd_du(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvabsd_du(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvmul_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmul_b(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmul_b(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvmul_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmul_h(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmul_h(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvmul_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmul_w(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmul_w(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvmul_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmul_d(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmul_d(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvmadd_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmadd_b(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmadd_b(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvmadd_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmadd_h(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmadd_h(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvmadd_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmadd_w(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmadd_w(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvmadd_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmadd_d(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmadd_d(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvmsub_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmsub_b(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmsub_b(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvmsub_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmsub_h(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmsub_h(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvmsub_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmsub_w(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmsub_w(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvmsub_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmsub_d(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmsub_d(0 /* m256i */, 0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvdiv_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvdiv_b(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvdiv_b(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvdiv_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvdiv_h(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvdiv_h(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvdiv_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvdiv_w(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvdiv_w(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvdiv_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvdiv_d(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvdiv_d(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvdiv_bu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvdiv_bu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvdiv_bu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvdiv_hu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvdiv_hu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvdiv_hu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvdiv_wu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvdiv_wu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvdiv_wu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvdiv_du() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvdiv_du(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvdiv_du(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvhaddw_h_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvhaddw_h_b(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvhaddw_h_b(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvhaddw_w_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvhaddw_w_h(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvhaddw_w_h(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvhaddw_d_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvhaddw_d_w(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvhaddw_d_w(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvhaddw_hu_bu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvhaddw_hu_bu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvhaddw_hu_bu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvhaddw_wu_hu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvhaddw_wu_hu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvhaddw_wu_hu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvhaddw_du_wu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvhaddw_du_wu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvhaddw_du_wu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvhsubw_h_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvhsubw_h_b(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvhsubw_h_b(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvhsubw_w_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvhsubw_w_h(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvhsubw_w_h(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvhsubw_d_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvhsubw_d_w(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvhsubw_d_w(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvhsubw_hu_bu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvhsubw_hu_bu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvhsubw_hu_bu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvhsubw_wu_hu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvhsubw_wu_hu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvhsubw_wu_hu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvhsubw_du_wu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvhsubw_du_wu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvhsubw_du_wu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvmod_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmod_b(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmod_b(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvmod_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmod_h(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmod_h(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvmod_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmod_w(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmod_w(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvmod_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmod_d(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmod_d(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvmod_bu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmod_bu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmod_bu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvmod_hu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmod_hu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmod_hu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvmod_wu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmod_wu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmod_wu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvmod_du() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmod_du(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmod_du(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvrepl128vei_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvrepl128vei_b::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvrepl128vei_b::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvrepl128vei_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvrepl128vei_h::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvrepl128vei_h::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvrepl128vei_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvrepl128vei_w::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvrepl128vei_w::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvrepl128vei_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvrepl128vei_d::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvrepl128vei_d::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvpickev_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvpickev_b(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvpickev_b(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvpickev_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvpickev_h(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvpickev_h(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}
