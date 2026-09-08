use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_loongarch64_lsx_lsx_vreplvei_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vreplvei_w::<0>(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vreplvei_w::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vreplvei_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vreplvei_d::<0>(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vreplvei_d::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vpickev_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vpickev_b(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpickev_b(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vpickev_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vpickev_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpickev_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vpickev_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vpickev_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpickev_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vpickev_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vpickev_d(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpickev_d(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vpickod_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vpickod_b(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpickod_b(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vpickod_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vpickod_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpickod_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vpickod_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vpickod_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpickod_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vpickod_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vpickod_d(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpickod_d(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vilvh_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vilvh_b(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vilvh_b(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vilvh_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vilvh_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vilvh_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vilvh_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vilvh_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vilvh_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vilvh_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vilvh_d(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vilvh_d(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vilvl_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vilvl_b(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vilvl_b(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vilvl_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vilvl_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vilvl_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vilvl_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vilvl_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vilvl_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vilvl_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vilvl_d(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vilvl_d(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vpackev_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vpackev_b(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpackev_b(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vpackev_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vpackev_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpackev_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vpackev_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vpackev_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpackev_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vpackev_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vpackev_d(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpackev_d(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vpackod_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vpackod_b(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpackod_b(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vpackod_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vpackod_h(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpackod_h(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vpackod_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vpackod_w(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpackod_w(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vpackod_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vpackod_d(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpackod_d(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vshuf_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vshuf_h(0 /* m128i */, 0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vshuf_h(0 /* m128i */, 0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vshuf_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vshuf_w(0 /* m128i */, 0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vshuf_w(0 /* m128i */, 0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vshuf_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vshuf_d(0 /* m128i */, 0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vshuf_d(0 /* m128i */, 0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vand_v() -> Result<(), String> {
    unsafe {
        let _result = lsx_vand_v(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vand_v(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vandi_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vandi_b::<0>(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vandi_b::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vor_v() -> Result<(), String> {
    unsafe {
        let _result = lsx_vor_v(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vor_v(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vori_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vori_b::<0>(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vori_b::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vnor_v() -> Result<(), String> {
    unsafe {
        let _result = lsx_vnor_v(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vnor_v(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vnori_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vnori_b::<0>(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vnori_b::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vxor_v() -> Result<(), String> {
    unsafe {
        let _result = lsx_vxor_v(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vxor_v(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vxori_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vxori_b::<0>(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vxori_b::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vbitsel_v() -> Result<(), String> {
    unsafe {
        let _result = lsx_vbitsel_v(0 /* m128i */, 0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vbitsel_v(0 /* m128i */, 0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vbitseli_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vbitseli_b::<0>(0 /* m128i */, 0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vbitseli_b::<0>(0 /* m128i */, 0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vshuf4i_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vshuf4i_b::<0>(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vshuf4i_b::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vshuf4i_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vshuf4i_h::<0>(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vshuf4i_h::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vshuf4i_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vshuf4i_w::<0>(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vshuf4i_w::<0>(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vreplgr2vr_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vreplgr2vr_b(1i32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vreplgr2vr_b(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vreplgr2vr_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vreplgr2vr_h(1i32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vreplgr2vr_h(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vreplgr2vr_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vreplgr2vr_w(1i32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vreplgr2vr_w(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vreplgr2vr_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vreplgr2vr_d(1i64);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vreplgr2vr_d(rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vpcnt_b() -> Result<(), String> {
    unsafe {
        let _result = lsx_vpcnt_b(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpcnt_b(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vpcnt_h() -> Result<(), String> {
    unsafe {
        let _result = lsx_vpcnt_h(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpcnt_h(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vpcnt_w() -> Result<(), String> {
    unsafe {
        let _result = lsx_vpcnt_w(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpcnt_w(0 /* m128i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lsx_lsx_vpcnt_d() -> Result<(), String> {
    unsafe {
        let _result = lsx_vpcnt_d(0 /* m128i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lsx_vpcnt_d(0 /* m128i */);
            }
        }
    }
    Ok(())
}
