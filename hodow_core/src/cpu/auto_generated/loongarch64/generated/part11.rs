use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_loongarch64_generated_lasx_vext2xv_d_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_vext2xv_d_h(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_vext2xv_d_h(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_vext2xv_d_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_vext2xv_d_b(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_vext2xv_d_b(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_vext2xv_hu_bu() -> Result<(), String> {
    unsafe {
        let _result = lasx_vext2xv_hu_bu(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_vext2xv_hu_bu(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_vext2xv_wu_hu() -> Result<(), String> {
    unsafe {
        let _result = lasx_vext2xv_wu_hu(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_vext2xv_wu_hu(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_vext2xv_du_wu() -> Result<(), String> {
    unsafe {
        let _result = lasx_vext2xv_du_wu(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_vext2xv_du_wu(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_vext2xv_wu_bu() -> Result<(), String> {
    unsafe {
        let _result = lasx_vext2xv_wu_bu(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_vext2xv_wu_bu(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_vext2xv_du_hu() -> Result<(), String> {
    unsafe {
        let _result = lasx_vext2xv_du_hu(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_vext2xv_du_hu(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_vext2xv_du_bu() -> Result<(), String> {
    unsafe {
        let _result = lasx_vext2xv_du_bu(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_vext2xv_du_bu(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvpermi_q() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvpermi_q::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvpermi_q::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvpermi_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvpermi_d::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvpermi_d::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvperm_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvperm_w(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvperm_w(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvldrepl_b() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let _result = lasx_xvldrepl_b::<0>(ptr_mem_addr.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvldrepl_h() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let _result = lasx_xvldrepl_h::<0>(ptr_mem_addr.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvldrepl_w() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let _result = lasx_xvldrepl_w::<0>(ptr_mem_addr.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvldrepl_d() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = crate::cpu::common::Aligned64([1i8; 64]);
        let _result = lasx_xvldrepl_d::<0>(ptr_mem_addr.0.as_ptr());
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvpickve2gr_w() -> Result<(), String> {
    unsafe {
        let result = lasx_xvpickve2gr_w::<0>(0 /* m256i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lasx_xvpickve2gr_w::<0>(0 /* m256i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvpickve2gr_w::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvpickve2gr_wu() -> Result<(), String> {
    unsafe {
        let result = lasx_xvpickve2gr_wu::<0>(0 /* m256i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lasx_xvpickve2gr_wu::<0>(0 /* m256i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvpickve2gr_wu::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvpickve2gr_d() -> Result<(), String> {
    unsafe {
        let result = lasx_xvpickve2gr_d::<0>(0 /* m256i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lasx_xvpickve2gr_d::<0>(0 /* m256i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvpickve2gr_d::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvpickve2gr_du() -> Result<(), String> {
    unsafe {
        let result = lasx_xvpickve2gr_du::<0>(0 /* m256i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lasx_xvpickve2gr_du::<0>(0 /* m256i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvpickve2gr_du::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvaddwev_q_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvaddwev_q_d(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvaddwev_q_d(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvaddwev_d_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvaddwev_d_w(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvaddwev_d_w(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvaddwev_w_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvaddwev_w_h(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvaddwev_w_h(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvaddwev_h_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvaddwev_h_b(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvaddwev_h_b(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvaddwev_q_du() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvaddwev_q_du(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvaddwev_q_du(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvaddwev_d_wu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvaddwev_d_wu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvaddwev_d_wu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvaddwev_w_hu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvaddwev_w_hu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvaddwev_w_hu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvaddwev_h_bu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvaddwev_h_bu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvaddwev_h_bu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvsubwev_q_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsubwev_q_d(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsubwev_q_d(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvsubwev_d_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsubwev_d_w(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsubwev_d_w(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvsubwev_w_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsubwev_w_h(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsubwev_w_h(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvsubwev_h_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsubwev_h_b(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsubwev_h_b(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvsubwev_q_du() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsubwev_q_du(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsubwev_q_du(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvsubwev_d_wu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsubwev_d_wu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsubwev_d_wu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvsubwev_w_hu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsubwev_w_hu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsubwev_w_hu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvsubwev_h_bu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsubwev_h_bu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsubwev_h_bu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvmulwev_q_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmulwev_q_d(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmulwev_q_d(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvmulwev_d_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmulwev_d_w(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmulwev_d_w(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvmulwev_w_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmulwev_w_h(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmulwev_w_h(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvmulwev_h_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmulwev_h_b(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmulwev_h_b(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvmulwev_q_du() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmulwev_q_du(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmulwev_q_du(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvmulwev_d_wu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmulwev_d_wu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmulwev_d_wu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvmulwev_w_hu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmulwev_w_hu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmulwev_w_hu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvmulwev_h_bu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvmulwev_h_bu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvmulwev_h_bu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvaddwod_q_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvaddwod_q_d(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvaddwod_q_d(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvaddwod_d_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvaddwod_d_w(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvaddwod_d_w(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvaddwod_w_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvaddwod_w_h(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvaddwod_w_h(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvaddwod_h_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvaddwod_h_b(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvaddwod_h_b(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvaddwod_q_du() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvaddwod_q_du(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvaddwod_q_du(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvaddwod_d_wu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvaddwod_d_wu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvaddwod_d_wu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_generated_lasx_xvaddwod_w_hu() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvaddwod_w_hu(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvaddwod_w_hu(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}
