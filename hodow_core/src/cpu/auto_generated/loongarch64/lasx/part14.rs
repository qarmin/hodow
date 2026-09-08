use std::arch::loongarch64::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_loongarch64_lasx_lasx_xvssrlrni_w_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrlrni_w_d::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrlrni_w_d::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrlrni_d_q() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrlrni_d_q::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrlrni_d_q::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrlrni_bu_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrlrni_bu_h::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrlrni_bu_h::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrlrni_hu_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrlrni_hu_w::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrlrni_hu_w::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrlrni_wu_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrlrni_wu_d::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrlrni_wu_d::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrlrni_du_q() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrlrni_du_q::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrlrni_du_q::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrani_b_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrani_b_h::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrani_b_h::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrani_h_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrani_h_w::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrani_h_w::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrani_w_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrani_w_d::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrani_w_d::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrani_d_q() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrani_d_q::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrani_d_q::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrarni_b_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrarni_b_h::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrarni_b_h::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrarni_h_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrarni_h_w::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrarni_h_w::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrarni_w_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrarni_w_d::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrarni_w_d::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvsrarni_d_q() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvsrarni_d_q::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvsrarni_d_q::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrani_b_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrani_b_h::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrani_b_h::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrani_h_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrani_h_w::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrani_h_w::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrani_w_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrani_w_d::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrani_w_d::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrani_d_q() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrani_d_q::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrani_d_q::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrani_bu_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrani_bu_h::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrani_bu_h::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrani_hu_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrani_hu_w::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrani_hu_w::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrani_wu_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrani_wu_d::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrani_wu_d::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrani_du_q() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrani_du_q::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrani_du_q::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrarni_b_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrarni_b_h::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrarni_b_h::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrarni_h_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrarni_h_w::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrarni_h_w::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrarni_w_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrarni_w_d::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrarni_w_d::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrarni_d_q() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrarni_d_q::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrarni_d_q::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrarni_bu_h() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrarni_bu_h::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrarni_bu_h::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrarni_hu_w() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrarni_hu_w::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrarni_hu_w::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrarni_wu_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrarni_wu_d::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrarni_wu_d::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvssrarni_du_q() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvssrarni_du_q::<0>(0 /* m256i */, 0 /* m256i */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvssrarni_du_q::<0>(0 /* m256i */, 0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xbnz_b() -> Result<(), String> {
    unsafe {
        let result = lasx_xbnz_b(0 /* m256i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lasx_xbnz_b(0 /* m256i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xbnz_b(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xbnz_d() -> Result<(), String> {
    unsafe {
        let result = lasx_xbnz_d(0 /* m256i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lasx_xbnz_d(0 /* m256i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xbnz_d(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xbnz_h() -> Result<(), String> {
    unsafe {
        let result = lasx_xbnz_h(0 /* m256i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lasx_xbnz_h(0 /* m256i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xbnz_h(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xbnz_v() -> Result<(), String> {
    unsafe {
        let result = lasx_xbnz_v(0 /* m256i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lasx_xbnz_v(0 /* m256i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xbnz_v(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xbnz_w() -> Result<(), String> {
    unsafe {
        let result = lasx_xbnz_w(0 /* m256i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lasx_xbnz_w(0 /* m256i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xbnz_w(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xbz_b() -> Result<(), String> {
    unsafe {
        let result = lasx_xbz_b(0 /* m256i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lasx_xbz_b(0 /* m256i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xbz_b(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xbz_d() -> Result<(), String> {
    unsafe {
        let result = lasx_xbz_d(0 /* m256i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lasx_xbz_d(0 /* m256i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xbz_d(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xbz_h() -> Result<(), String> {
    unsafe {
        let result = lasx_xbz_h(0 /* m256i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lasx_xbz_h(0 /* m256i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xbz_h(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xbz_v() -> Result<(), String> {
    unsafe {
        let result = lasx_xbz_v(0 /* m256i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lasx_xbz_v(0 /* m256i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xbz_v(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xbz_w() -> Result<(), String> {
    unsafe {
        let result = lasx_xbz_w(0 /* m256i */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: lasx_xbz_w(0 /* m256i */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xbz_w(0 /* m256i */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_caf_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_caf_d(0 /* m256d */, 0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_caf_d(0 /* m256d */, 0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_caf_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_caf_s(0 /* m256 */, 0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_caf_s(0 /* m256 */, 0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_ceq_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_ceq_d(0 /* m256d */, 0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_ceq_d(0 /* m256d */, 0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_ceq_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_ceq_s(0 /* m256 */, 0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_ceq_s(0 /* m256 */, 0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cle_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_cle_d(0 /* m256d */, 0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_cle_d(0 /* m256d */, 0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cle_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_cle_s(0 /* m256 */, 0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_cle_s(0 /* m256 */, 0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_clt_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_clt_d(0 /* m256d */, 0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_clt_d(0 /* m256d */, 0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_clt_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_clt_s(0 /* m256 */, 0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_clt_s(0 /* m256 */, 0 /* m256 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cne_d() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_cne_d(0 /* m256d */, 0 /* m256d */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_cne_d(0 /* m256d */, 0 /* m256d */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_loongarch64_lasx_lasx_xvfcmp_cne_s() -> Result<(), String> {
    unsafe {
        let _result = lasx_xvfcmp_cne_s(0 /* m256 */, 0 /* m256 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = lasx_xvfcmp_cne_s(0 /* m256 */, 0 /* m256 */);
            }
        }
    }
    Ok(())
}
