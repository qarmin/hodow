use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_loongarch64_lsx_lsx_vsrarn_w_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsrarn_w_d(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsrarn_w_d(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vssrarn_b_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vssrarn_b_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vssrarn_b_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vssrarn_h_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vssrarn_h_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vssrarn_h_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vssrarn_w_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vssrarn_w_d(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vssrarn_w_d(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vssrarn_bu_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vssrarn_bu_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vssrarn_bu_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vssrarn_hu_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vssrarn_hu_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vssrarn_hu_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vssrarn_wu_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vssrarn_wu_d(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vssrarn_wu_d(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsrln_b_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsrln_b_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsrln_b_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsrln_h_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsrln_h_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsrln_h_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsrln_w_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsrln_w_d(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsrln_w_d(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vssrln_bu_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vssrln_bu_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vssrln_bu_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vssrln_hu_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vssrln_hu_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vssrln_hu_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vssrln_wu_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vssrln_wu_d(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vssrln_wu_d(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsrlrn_b_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsrlrn_b_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsrlrn_b_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsrlrn_h_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsrlrn_h_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsrlrn_h_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsrlrn_w_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsrlrn_w_d(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsrlrn_w_d(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vssrlrn_bu_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vssrlrn_bu_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vssrlrn_bu_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vssrlrn_hu_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vssrlrn_hu_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vssrlrn_hu_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vssrlrn_wu_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vssrlrn_wu_d(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vssrlrn_wu_d(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfrstpi_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfrstpi_b::<0>(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfrstpi_b::<0>(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfrstpi_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfrstpi_h::<0>(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfrstpi_h::<0>(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfrstp_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfrstp_b(0 /* m128i */, 0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfrstp_b(0 /* m128i */, 0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfrstp_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfrstp_h(0 /* m128i */, 0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfrstp_h(0 /* m128i */, 0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vshuf4i_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vshuf4i_d::<0>(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vshuf4i_d::<0>(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vbsrl_v() -> Result<(), String> {
    unsafe {
        let _result = lsx_vbsrl_v::<0>(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vbsrl_v::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vbsll_v() -> Result<(), String> {
    unsafe {
        let _result = lsx_vbsll_v::<0>(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vbsll_v::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vextrins_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vextrins_b::<0>(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vextrins_b::<0>(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vextrins_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vextrins_h::<0>(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vextrins_h::<0>(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vextrins_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vextrins_w::<0>(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vextrins_w::<0>(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vextrins_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vextrins_d::<0>(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vextrins_d::<0>(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vmskltz_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vmskltz_b(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vmskltz_b(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vmskltz_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vmskltz_h(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vmskltz_h(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vmskltz_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vmskltz_w(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vmskltz_w(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vmskltz_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vmskltz_d(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vmskltz_d(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsigncov_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsigncov_b(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsigncov_b(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsigncov_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsigncov_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsigncov_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsigncov_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsigncov_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsigncov_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsigncov_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsigncov_d(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsigncov_d(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfmadd_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfmadd_s(0 /* m128 */, 0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfmadd_s(0 /* m128 */, 0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfmadd_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfmadd_d(0 /* m128d */, 0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfmadd_d(0 /* m128d */, 0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfmsub_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfmsub_s(0 /* m128 */, 0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfmsub_s(0 /* m128 */, 0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfmsub_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfmsub_d(0 /* m128d */, 0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfmsub_d(0 /* m128d */, 0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfnmadd_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfnmadd_s(0 /* m128 */, 0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfnmadd_s(0 /* m128 */, 0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfnmadd_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfnmadd_d(0 /* m128d */, 0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfnmadd_d(0 /* m128d */, 0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfnmsub_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfnmsub_s(0 /* m128 */, 0 /* m128 */, 0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfnmsub_s(0 /* m128 */, 0 /* m128 */, 0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vfnmsub_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vfnmsub_d(0 /* m128d */, 0 /* m128d */, 0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vfnmsub_d(0 /* m128d */, 0 /* m128d */, 0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vftintrne_w_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vftintrne_w_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vftintrne_w_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vftintrne_l_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vftintrne_l_d(0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vftintrne_l_d(0 /* m128d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vftintrp_w_s() -> Result<(), String> {
    unsafe {
        let _result = lsx_vftintrp_w_s(0 /* m128 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vftintrp_w_s(0 /* m128 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vftintrp_l_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vftintrp_l_d(0 /* m128d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vftintrp_l_d(0 /* m128d */);
            }
        }
    }
    Ok(())
}
