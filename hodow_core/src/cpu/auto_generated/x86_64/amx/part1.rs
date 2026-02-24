use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_tile_loadconfig() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1u8; 1];
        _tile_loadconfig(ptr_mem_addr.as_ptr());
    }
    Ok(())
}

pub(super) fn test_tile_storeconfig() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1u8; 1];
        _tile_storeconfig(ptr_mem_addr.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_tile_loadd() -> Result<(), String> {
    unsafe {
        let ptr_base = [1u8; 1];
        let stride = 0usize;
        _tile_loadd::<0>(ptr_base.as_ptr(), stride);
    }
    Ok(())
}

pub(super) fn test_tile_release() -> Result<(), String> {
    unsafe {
        _tile_release();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _tile_release();
            }
        }
    }
    Ok(())
}

pub(super) fn test_tile_stored() -> Result<(), String> {
    unsafe {
        let mut ptr_base = [1u8; 1];
        let stride = 0usize;
        _tile_stored::<0>(ptr_base.as_mut_ptr(), stride);
    }
    Ok(())
}

pub(super) fn test_tile_stream_loadd() -> Result<(), String> {
    unsafe {
        let ptr_base = [1u8; 1];
        let stride = 0usize;
        _tile_stream_loadd::<0>(ptr_base.as_ptr(), stride);
    }
    Ok(())
}

pub(super) fn test_tile_zero() -> Result<(), String> {
    unsafe {
        _tile_zero::<0>();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _tile_zero::<0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_tile_dpbf16ps() -> Result<(), String> {
    unsafe {
        _tile_dpbf16ps::<0, 0, 0>();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _tile_dpbf16ps::<0, 0, 0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_tile_dpbssd() -> Result<(), String> {
    unsafe {
        _tile_dpbssd::<0, 0, 0>();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _tile_dpbssd::<0, 0, 0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_tile_dpbsud() -> Result<(), String> {
    unsafe {
        _tile_dpbsud::<0, 0, 0>();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _tile_dpbsud::<0, 0, 0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_tile_dpbusd() -> Result<(), String> {
    unsafe {
        _tile_dpbusd::<0, 0, 0>();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _tile_dpbusd::<0, 0, 0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_tile_dpbuud() -> Result<(), String> {
    unsafe {
        _tile_dpbuud::<0, 0, 0>();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _tile_dpbuud::<0, 0, 0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_tile_dpfp16ps() -> Result<(), String> {
    unsafe {
        _tile_dpfp16ps::<0, 0, 0>();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _tile_dpfp16ps::<0, 0, 0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_tile_cmmimfp16ps() -> Result<(), String> {
    unsafe {
        _tile_cmmimfp16ps::<0, 0, 0>();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _tile_cmmimfp16ps::<0, 0, 0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_tile_cmmrlfp16ps() -> Result<(), String> {
    unsafe {
        _tile_cmmrlfp16ps::<0, 0, 0>();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _tile_cmmrlfp16ps::<0, 0, 0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_tile_dpbf8ps() -> Result<(), String> {
    unsafe {
        _tile_dpbf8ps::<0, 0, 0>();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _tile_dpbf8ps::<0, 0, 0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_tile_dpbhf8ps() -> Result<(), String> {
    unsafe {
        _tile_dpbhf8ps::<0, 0, 0>();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _tile_dpbhf8ps::<0, 0, 0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_tile_dphbf8ps() -> Result<(), String> {
    unsafe {
        _tile_dphbf8ps::<0, 0, 0>();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _tile_dphbf8ps::<0, 0, 0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_tile_dphf8ps() -> Result<(), String> {
    unsafe {
        _tile_dphf8ps::<0, 0, 0>();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _tile_dphf8ps::<0, 0, 0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_tile_loaddrs() -> Result<(), String> {
    unsafe {
        let ptr_base = [1u8; 1];
        let stride = 0usize;
        _tile_loaddrs::<0>(ptr_base.as_ptr(), stride);
    }
    Ok(())
}

pub(super) fn test_tile_stream_loaddrs() -> Result<(), String> {
    unsafe {
        let ptr_base = [1u8; 1];
        let stride = 0usize;
        _tile_stream_loaddrs::<0>(ptr_base.as_ptr(), stride);
    }
    Ok(())
}

pub(super) fn test_tile_mmultf32ps() -> Result<(), String> {
    unsafe {
        _tile_mmultf32ps::<0, 0, 0>();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _tile_mmultf32ps::<0, 0, 0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_tile_cvtrowd2ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_tile_cvtrowd2ps::<0>(1u32));
        check_float_array_equality(&result, &[0.0f32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _tile_cvtrowd2ps::<0>(rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_tile_movrow() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_tile_movrow::<0>(1u32));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _tile_movrow::<0>(rand::random::<u32>());
            }
        }
    }
    Ok(())
}
