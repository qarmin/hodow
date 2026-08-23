use std::arch::riscv64::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_riscv_shared_p_srl8() -> Result<(), String> {
    unsafe {
        let _result = srl8(0usize, 1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = srl8(rand::random::<usize>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_srl8u() -> Result<(), String> {
    unsafe {
        let _result = srl8u(0usize, 1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = srl8u(rand::random::<usize>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_sll8() -> Result<(), String> {
    unsafe {
        let _result = sll8(0usize, 1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sll8(rand::random::<usize>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_ksll8() -> Result<(), String> {
    unsafe {
        let _result = ksll8(0usize, 1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = ksll8(rand::random::<usize>(), rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_kslra8() -> Result<(), String> {
    unsafe {
        let _result = kslra8(0usize, 1i32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = kslra8(rand::random::<usize>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_kslra8u() -> Result<(), String> {
    unsafe {
        let _result = kslra8u(0usize, 1i32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = kslra8u(rand::random::<usize>(), rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_cmpeq16() -> Result<(), String> {
    unsafe {
        let _result = cmpeq16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = cmpeq16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_scmplt16() -> Result<(), String> {
    unsafe {
        let _result = scmplt16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = scmplt16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_scmple16() -> Result<(), String> {
    unsafe {
        let _result = scmple16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = scmple16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_ucmplt16() -> Result<(), String> {
    unsafe {
        let _result = ucmplt16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = ucmplt16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_ucmple16() -> Result<(), String> {
    unsafe {
        let _result = ucmple16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = ucmple16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_cmpeq8() -> Result<(), String> {
    unsafe {
        let _result = cmpeq8(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = cmpeq8(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_scmplt8() -> Result<(), String> {
    unsafe {
        let _result = scmplt8(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = scmplt8(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_scmple8() -> Result<(), String> {
    unsafe {
        let _result = scmple8(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = scmple8(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_ucmplt8() -> Result<(), String> {
    unsafe {
        let _result = ucmplt8(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = ucmplt8(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_ucmple8() -> Result<(), String> {
    unsafe {
        let _result = ucmple8(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = ucmple8(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_smin16() -> Result<(), String> {
    unsafe {
        let _result = smin16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = smin16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_umin16() -> Result<(), String> {
    unsafe {
        let _result = umin16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = umin16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_smax16() -> Result<(), String> {
    unsafe {
        let _result = smax16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = smax16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_umax16() -> Result<(), String> {
    unsafe {
        let _result = umax16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = umax16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_kabs16() -> Result<(), String> {
    unsafe {
        let _result = kabs16(0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = kabs16(rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_clrs16() -> Result<(), String> {
    unsafe {
        let _result = clrs16(0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = clrs16(rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_clz16() -> Result<(), String> {
    unsafe {
        let _result = clz16(0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = clz16(rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_swap16() -> Result<(), String> {
    unsafe {
        let _result = swap16(0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = swap16(rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_smin8() -> Result<(), String> {
    unsafe {
        let _result = smin8(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = smin8(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_umin8() -> Result<(), String> {
    unsafe {
        let _result = umin8(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = umin8(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_smax8() -> Result<(), String> {
    unsafe {
        let _result = smax8(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = smax8(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_umax8() -> Result<(), String> {
    unsafe {
        let _result = umax8(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = umax8(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_kabs8() -> Result<(), String> {
    unsafe {
        let _result = kabs8(0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = kabs8(rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_clrs8() -> Result<(), String> {
    unsafe {
        let _result = clrs8(0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = clrs8(rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_clz8() -> Result<(), String> {
    unsafe {
        let _result = clz8(0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = clz8(rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_swap8() -> Result<(), String> {
    unsafe {
        let _result = swap8(0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = swap8(rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_sunpkd810() -> Result<(), String> {
    unsafe {
        let _result = sunpkd810(0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sunpkd810(rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_sunpkd820() -> Result<(), String> {
    unsafe {
        let _result = sunpkd820(0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sunpkd820(rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_sunpkd830() -> Result<(), String> {
    unsafe {
        let _result = sunpkd830(0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sunpkd830(rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_sunpkd831() -> Result<(), String> {
    unsafe {
        let _result = sunpkd831(0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sunpkd831(rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_sunpkd832() -> Result<(), String> {
    unsafe {
        let _result = sunpkd832(0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = sunpkd832(rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_zunpkd810() -> Result<(), String> {
    unsafe {
        let _result = zunpkd810(0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = zunpkd810(rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_zunpkd820() -> Result<(), String> {
    unsafe {
        let _result = zunpkd820(0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = zunpkd820(rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_zunpkd830() -> Result<(), String> {
    unsafe {
        let _result = zunpkd830(0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = zunpkd830(rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_zunpkd831() -> Result<(), String> {
    unsafe {
        let _result = zunpkd831(0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = zunpkd831(rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_zunpkd832() -> Result<(), String> {
    unsafe {
        let _result = zunpkd832(0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = zunpkd832(rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_pkbt16() -> Result<(), String> {
    unsafe {
        let _result = pkbt16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = pkbt16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_pktb16() -> Result<(), String> {
    unsafe {
        let _result = pktb16(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = pktb16(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_clrs32() -> Result<(), String> {
    unsafe {
        let _result = clrs32(0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = clrs32(rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_clz32() -> Result<(), String> {
    unsafe {
        let _result = clz32(0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = clz32(rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_pbsad() -> Result<(), String> {
    unsafe {
        let _result = pbsad(0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = pbsad(rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_pbsada() -> Result<(), String> {
    unsafe {
        let _result = pbsada(0usize, 0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = pbsada(rand::random::<usize>(), rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_smaqa() -> Result<(), String> {
    unsafe {
        let _result = smaqa(0usize, 0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = smaqa(rand::random::<usize>(), rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_riscv_shared_p_umaqa() -> Result<(), String> {
    unsafe {
        let _result = umaqa(0usize, 0usize, 0usize);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = umaqa(rand::random::<usize>(), rand::random::<usize>(), rand::random::<usize>());
            }
        }
    }
    Ok(())
}
