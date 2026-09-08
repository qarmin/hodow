use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_loongarch64_lasx_lasx_xvsll_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsll_b(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsll_b(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsll_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsll_h(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsll_h(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsll_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsll_w(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsll_w(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsll_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsll_d(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsll_d(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvslli_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvslli_b::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvslli_b::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvslli_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvslli_h::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvslli_h::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvslli_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvslli_w::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvslli_w::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvslli_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvslli_d::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvslli_d::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsra_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsra_b(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsra_b(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsra_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsra_h(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsra_h(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsra_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsra_w(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsra_w(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsra_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsra_d(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsra_d(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrai_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrai_b::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrai_b::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrai_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrai_h::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrai_h::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrai_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrai_w::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrai_w::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrai_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrai_d::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrai_d::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrar_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrar_b(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrar_b(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrar_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrar_h(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrar_h(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrar_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrar_w(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrar_w(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrar_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrar_d(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrar_d(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrari_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrari_b::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrari_b::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrari_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrari_h::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrari_h::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrari_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrari_w::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrari_w::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrari_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrari_d::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrari_d::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrl_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrl_b(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrl_b(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrl_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrl_h(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrl_h(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrl_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrl_w(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrl_w(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrl_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrl_d(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrl_d(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrli_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrli_b::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrli_b::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrli_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrli_h::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrli_h::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrli_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrli_w::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrli_w::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrli_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrli_d::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrli_d::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrlr_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrlr_b(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrlr_b(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrlr_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrlr_h(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrlr_h(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrlr_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrlr_w(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrlr_w(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrlr_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrlr_d(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrlr_d(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrlri_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrlri_b::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrlri_b::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrlri_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrlri_h::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrlri_h::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrlri_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrlri_w::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrlri_w::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrlri_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrlri_d::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrlri_d::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvbitclr_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvbitclr_b(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvbitclr_b(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvbitclr_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvbitclr_h(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvbitclr_h(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvbitclr_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvbitclr_w(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvbitclr_w(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvbitclr_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvbitclr_d(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvbitclr_d(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvbitclri_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvbitclri_b::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvbitclri_b::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvbitclri_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvbitclri_h::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvbitclri_h::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvbitclri_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvbitclri_w::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvbitclri_w::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvbitclri_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvbitclri_d::<0>(0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvbitclri_d::<0>(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvbitset_b() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvbitset_b(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvbitset_b(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvbitset_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvbitset_h(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvbitset_h(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}
