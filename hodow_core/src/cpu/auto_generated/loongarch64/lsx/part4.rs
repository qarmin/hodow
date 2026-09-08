use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_loongarch64_lsx_lsx_vslei_wu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vslei_wu::<0>(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vslei_wu::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vslei_du() -> Result<(), String> {
    unsafe {
        let _result = lsx_vslei_du::<0>(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vslei_du::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsat_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsat_b::<0>(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsat_b::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsat_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsat_h::<0>(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsat_h::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsat_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsat_w::<0>(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsat_w::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsat_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsat_d::<0>(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsat_d::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsat_bu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsat_bu::<0>(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsat_bu::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsat_hu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsat_hu::<0>(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsat_hu::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsat_wu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsat_wu::<0>(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsat_wu::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsat_du() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsat_du::<0>(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsat_du::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vadda_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vadda_b(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vadda_b(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vadda_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vadda_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vadda_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vadda_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vadda_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vadda_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vadda_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vadda_d(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vadda_d(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsadd_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsadd_b(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsadd_b(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsadd_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsadd_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsadd_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsadd_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsadd_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsadd_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsadd_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsadd_d(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsadd_d(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsadd_bu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsadd_bu(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsadd_bu(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsadd_hu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsadd_hu(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsadd_hu(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsadd_wu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsadd_wu(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsadd_wu(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vsadd_du() -> Result<(), String> {
    unsafe {
        let _result = lsx_vsadd_du(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vsadd_du(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vavg_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vavg_b(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vavg_b(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vavg_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vavg_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vavg_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vavg_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vavg_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vavg_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vavg_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vavg_d(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vavg_d(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vavg_bu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vavg_bu(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vavg_bu(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vavg_hu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vavg_hu(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vavg_hu(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vavg_wu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vavg_wu(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vavg_wu(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vavg_du() -> Result<(), String> {
    unsafe {
        let _result = lsx_vavg_du(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vavg_du(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vavgr_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vavgr_b(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vavgr_b(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vavgr_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vavgr_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vavgr_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vavgr_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vavgr_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vavgr_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vavgr_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vavgr_d(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vavgr_d(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vavgr_bu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vavgr_bu(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vavgr_bu(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vavgr_hu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vavgr_hu(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vavgr_hu(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vavgr_wu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vavgr_wu(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vavgr_wu(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vavgr_du() -> Result<(), String> {
    unsafe {
        let _result = lsx_vavgr_du(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vavgr_du(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vssub_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vssub_b(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vssub_b(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vssub_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vssub_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vssub_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vssub_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vssub_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vssub_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vssub_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vssub_d(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vssub_d(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vssub_bu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vssub_bu(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vssub_bu(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vssub_hu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vssub_hu(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vssub_hu(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vssub_wu() -> Result<(), String> {
    unsafe {
        let _result = lsx_vssub_wu(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vssub_wu(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vssub_du() -> Result<(), String> {
    unsafe {
        let _result = lsx_vssub_du(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vssub_du(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vabsd_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vabsd_b(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vabsd_b(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vabsd_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vabsd_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vabsd_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vabsd_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vabsd_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vabsd_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vabsd_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vabsd_d(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vabsd_d(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}
