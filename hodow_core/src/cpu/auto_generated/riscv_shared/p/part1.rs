use std::arch::riscv64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_riscv_shared_p_add16() -> Result<(), String> {
    unsafe {
        let _result = add16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = add16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_radd16() -> Result<(), String> {
    unsafe {
        let _result = radd16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = radd16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_uradd16() -> Result<(), String> {
    unsafe {
        let _result = uradd16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = uradd16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_kadd16() -> Result<(), String> {
    unsafe {
        let _result = kadd16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = kadd16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_ukadd16() -> Result<(), String> {
    unsafe {
        let _result = ukadd16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = ukadd16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_sub16() -> Result<(), String> {
    unsafe {
        let _result = sub16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sub16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_rsub16() -> Result<(), String> {
    unsafe {
        let _result = rsub16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = rsub16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_ursub16() -> Result<(), String> {
    unsafe {
        let _result = ursub16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = ursub16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_ksub16() -> Result<(), String> {
    unsafe {
        let _result = ksub16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = ksub16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_uksub16() -> Result<(), String> {
    unsafe {
        let _result = uksub16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = uksub16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_cras16() -> Result<(), String> {
    unsafe {
        let _result = cras16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = cras16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_rcras16() -> Result<(), String> {
    unsafe {
        let _result = rcras16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = rcras16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_urcras16() -> Result<(), String> {
    unsafe {
        let _result = urcras16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = urcras16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_kcras16() -> Result<(), String> {
    unsafe {
        let _result = kcras16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = kcras16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_ukcras16() -> Result<(), String> {
    unsafe {
        let _result = ukcras16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = ukcras16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_crsa16() -> Result<(), String> {
    unsafe {
        let _result = crsa16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = crsa16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_rcrsa16() -> Result<(), String> {
    unsafe {
        let _result = rcrsa16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = rcrsa16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_urcrsa16() -> Result<(), String> {
    unsafe {
        let _result = urcrsa16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = urcrsa16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_kcrsa16() -> Result<(), String> {
    unsafe {
        let _result = kcrsa16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = kcrsa16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_ukcrsa16() -> Result<(), String> {
    unsafe {
        let _result = ukcrsa16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = ukcrsa16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_stas16() -> Result<(), String> {
    unsafe {
        let _result = stas16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = stas16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_rstas16() -> Result<(), String> {
    unsafe {
        let _result = rstas16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = rstas16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_urstas16() -> Result<(), String> {
    unsafe {
        let _result = urstas16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = urstas16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_kstas16() -> Result<(), String> {
    unsafe {
        let _result = kstas16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = kstas16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_ukstas16() -> Result<(), String> {
    unsafe {
        let _result = ukstas16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = ukstas16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_stsa16() -> Result<(), String> {
    unsafe {
        let _result = stsa16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = stsa16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_rstsa16() -> Result<(), String> {
    unsafe {
        let _result = rstsa16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = rstsa16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_urstsa16() -> Result<(), String> {
    unsafe {
        let _result = urstsa16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = urstsa16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_kstsa16() -> Result<(), String> {
    unsafe {
        let _result = kstsa16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = kstsa16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_ukstsa16() -> Result<(), String> {
    unsafe {
        let _result = ukstsa16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = ukstsa16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_add8() -> Result<(), String> {
    unsafe {
        let _result = add8(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = add8(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_radd8() -> Result<(), String> {
    unsafe {
        let _result = radd8(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = radd8(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_uradd8() -> Result<(), String> {
    unsafe {
        let _result = uradd8(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = uradd8(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_kadd8() -> Result<(), String> {
    unsafe {
        let _result = kadd8(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = kadd8(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_ukadd8() -> Result<(), String> {
    unsafe {
        let _result = ukadd8(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = ukadd8(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_sub8() -> Result<(), String> {
    unsafe {
        let _result = sub8(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sub8(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_rsub8() -> Result<(), String> {
    unsafe {
        let _result = rsub8(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = rsub8(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_ursub8() -> Result<(), String> {
    unsafe {
        let _result = ursub8(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = ursub8(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_ksub8() -> Result<(), String> {
    unsafe {
        let _result = ksub8(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = ksub8(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_uksub8() -> Result<(), String> {
    unsafe {
        let _result = uksub8(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = uksub8(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_sra16() -> Result<(), String> {
    unsafe {
        let _result = sra16(0usize, 1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sra16(rand::random::<usize>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_sra16u() -> Result<(), String> {
    unsafe {
        let _result = sra16u(0usize, 1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sra16u(rand::random::<usize>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_srl16() -> Result<(), String> {
    unsafe {
        let _result = srl16(0usize, 1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = srl16(rand::random::<usize>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_srl16u() -> Result<(), String> {
    unsafe {
        let _result = srl16u(0usize, 1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = srl16u(rand::random::<usize>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_sll16() -> Result<(), String> {
    unsafe {
        let _result = sll16(0usize, 1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sll16(rand::random::<usize>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_ksll16() -> Result<(), String> {
    unsafe {
        let _result = ksll16(0usize, 1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = ksll16(rand::random::<usize>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_kslra16() -> Result<(), String> {
    unsafe {
        let _result = kslra16(0usize, 1i32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = kslra16(rand::random::<usize>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_kslra16u() -> Result<(), String> {
    unsafe {
        let _result = kslra16u(0usize, 1i32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = kslra16u(rand::random::<usize>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_sra8() -> Result<(), String> {
    unsafe {
        let _result = sra8(0usize, 1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sra8(rand::random::<usize>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_sra8u() -> Result<(), String> {
    unsafe {
        let _result = sra8u(0usize, 1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sra8u(rand::random::<usize>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}
