use std::arch::mips::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_msa_add_a_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_add_a_b(0 /* v16i8 */, 0 /* v16i8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_add_a_b(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_add_a_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_add_a_h(0 /* v8i16 */, 0 /* v8i16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_add_a_h(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_add_a_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_add_a_w(0 /* v4i32 */, 0 /* v4i32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_add_a_w(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_add_a_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_add_a_d(0 /* v2i64 */, 0 /* v2i64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_add_a_d(0 /* v2i64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_adds_a_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_adds_a_b(0 /* v16i8 */, 0 /* v16i8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_adds_a_b(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_adds_a_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_adds_a_h(0 /* v8i16 */, 0 /* v8i16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_adds_a_h(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_adds_a_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_adds_a_w(0 /* v4i32 */, 0 /* v4i32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_adds_a_w(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_adds_a_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_adds_a_d(0 /* v2i64 */, 0 /* v2i64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_adds_a_d(0 /* v2i64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_adds_s_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_adds_s_b(0 /* v16i8 */, 0 /* v16i8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_adds_s_b(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_adds_s_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_adds_s_h(0 /* v8i16 */, 0 /* v8i16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_adds_s_h(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_adds_s_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_adds_s_w(0 /* v4i32 */, 0 /* v4i32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_adds_s_w(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_adds_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_adds_s_d(0 /* v2i64 */, 0 /* v2i64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_adds_s_d(0 /* v2i64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_adds_u_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_adds_u_b(0 /* v16u8 */, 0 /* v16u8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_adds_u_b(0 /* v16u8 */, 0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_adds_u_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_adds_u_h(0 /* v8u16 */, 0 /* v8u16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_adds_u_h(0 /* v8u16 */, 0 /* v8u16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_adds_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_adds_u_w(0 /* v4u32 */, 0 /* v4u32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_adds_u_w(0 /* v4u32 */, 0 /* v4u32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_adds_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_adds_u_d(0 /* v2u64 */, 0 /* v2u64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_adds_u_d(0 /* v2u64 */, 0 /* v2u64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_addv_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_addv_b(0 /* v16i8 */, 0 /* v16i8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_addv_b(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_addv_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_addv_h(0 /* v8i16 */, 0 /* v8i16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_addv_h(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_addv_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_addv_w(0 /* v4i32 */, 0 /* v4i32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_addv_w(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_addv_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_addv_d(0 /* v2i64 */, 0 /* v2i64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_addv_d(0 /* v2i64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_addvi_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_addvi_b::<0>(0 /* v16i8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_addvi_b::<0>(0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_addvi_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_addvi_h::<0>(0 /* v8i16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_addvi_h::<0>(0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_addvi_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_addvi_w::<0>(0 /* v4i32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_addvi_w::<0>(0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_addvi_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_addvi_d::<0>(0 /* v2i64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_addvi_d::<0>(0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_and_v() -> Result<(), String> {
    unsafe {
        let _result = __msa_and_v(0 /* v16u8 */, 0 /* v16u8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_and_v(0 /* v16u8 */, 0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_andi_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_andi_b::<0>(0 /* v16u8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_andi_b::<0>(0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_asub_s_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_asub_s_b(0 /* v16i8 */, 0 /* v16i8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_asub_s_b(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_asub_s_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_asub_s_h(0 /* v8i16 */, 0 /* v8i16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_asub_s_h(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_asub_s_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_asub_s_w(0 /* v4i32 */, 0 /* v4i32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_asub_s_w(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_asub_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_asub_s_d(0 /* v2i64 */, 0 /* v2i64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_asub_s_d(0 /* v2i64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_asub_u_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_asub_u_b(0 /* v16u8 */, 0 /* v16u8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_asub_u_b(0 /* v16u8 */, 0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_asub_u_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_asub_u_h(0 /* v8u16 */, 0 /* v8u16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_asub_u_h(0 /* v8u16 */, 0 /* v8u16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_asub_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_asub_u_w(0 /* v4u32 */, 0 /* v4u32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_asub_u_w(0 /* v4u32 */, 0 /* v4u32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_asub_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_asub_u_d(0 /* v2u64 */, 0 /* v2u64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_asub_u_d(0 /* v2u64 */, 0 /* v2u64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_ave_s_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_ave_s_b(0 /* v16i8 */, 0 /* v16i8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ave_s_b(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_ave_s_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_ave_s_h(0 /* v8i16 */, 0 /* v8i16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ave_s_h(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_ave_s_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_ave_s_w(0 /* v4i32 */, 0 /* v4i32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ave_s_w(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_ave_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_ave_s_d(0 /* v2i64 */, 0 /* v2i64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ave_s_d(0 /* v2i64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_ave_u_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_ave_u_b(0 /* v16u8 */, 0 /* v16u8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ave_u_b(0 /* v16u8 */, 0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_ave_u_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_ave_u_h(0 /* v8u16 */, 0 /* v8u16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ave_u_h(0 /* v8u16 */, 0 /* v8u16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_ave_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_ave_u_w(0 /* v4u32 */, 0 /* v4u32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ave_u_w(0 /* v4u32 */, 0 /* v4u32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_ave_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_ave_u_d(0 /* v2u64 */, 0 /* v2u64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ave_u_d(0 /* v2u64 */, 0 /* v2u64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_aver_s_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_aver_s_b(0 /* v16i8 */, 0 /* v16i8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_aver_s_b(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_aver_s_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_aver_s_h(0 /* v8i16 */, 0 /* v8i16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_aver_s_h(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_aver_s_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_aver_s_w(0 /* v4i32 */, 0 /* v4i32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_aver_s_w(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_aver_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_aver_s_d(0 /* v2i64 */, 0 /* v2i64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_aver_s_d(0 /* v2i64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_aver_u_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_aver_u_b(0 /* v16u8 */, 0 /* v16u8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_aver_u_b(0 /* v16u8 */, 0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_aver_u_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_aver_u_h(0 /* v8u16 */, 0 /* v8u16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_aver_u_h(0 /* v8u16 */, 0 /* v8u16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_aver_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_aver_u_w(0 /* v4u32 */, 0 /* v4u32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_aver_u_w(0 /* v4u32 */, 0 /* v4u32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_aver_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_aver_u_d(0 /* v2u64 */, 0 /* v2u64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_aver_u_d(0 /* v2u64 */, 0 /* v2u64 */);
            }
        }
    }
    Ok(())
}
