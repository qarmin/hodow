use std::arch::mips::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_msa_subs_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_subs_s_d(0 /* v2i64 */, 0 /* v2i64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_subs_s_d(0 /* v2i64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_subs_u_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_subs_u_b(0 /* v16u8 */, 0 /* v16u8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_subs_u_b(0 /* v16u8 */, 0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_subs_u_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_subs_u_h(0 /* v8u16 */, 0 /* v8u16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_subs_u_h(0 /* v8u16 */, 0 /* v8u16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_subs_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_subs_u_w(0 /* v4u32 */, 0 /* v4u32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_subs_u_w(0 /* v4u32 */, 0 /* v4u32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_subs_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_subs_u_d(0 /* v2u64 */, 0 /* v2u64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_subs_u_d(0 /* v2u64 */, 0 /* v2u64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_subsus_u_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_subsus_u_b(0 /* v16u8 */, 0 /* v16i8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_subsus_u_b(0 /* v16u8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_subsus_u_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_subsus_u_h(0 /* v8u16 */, 0 /* v8i16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_subsus_u_h(0 /* v8u16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_subsus_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_subsus_u_w(0 /* v4u32 */, 0 /* v4i32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_subsus_u_w(0 /* v4u32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_subsus_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_subsus_u_d(0 /* v2u64 */, 0 /* v2i64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_subsus_u_d(0 /* v2u64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_subsuu_s_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_subsuu_s_b(0 /* v16u8 */, 0 /* v16u8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_subsuu_s_b(0 /* v16u8 */, 0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_subsuu_s_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_subsuu_s_h(0 /* v8u16 */, 0 /* v8u16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_subsuu_s_h(0 /* v8u16 */, 0 /* v8u16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_subsuu_s_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_subsuu_s_w(0 /* v4u32 */, 0 /* v4u32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_subsuu_s_w(0 /* v4u32 */, 0 /* v4u32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_subsuu_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_subsuu_s_d(0 /* v2u64 */, 0 /* v2u64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_subsuu_s_d(0 /* v2u64 */, 0 /* v2u64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_subv_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_subv_b(0 /* v16i8 */, 0 /* v16i8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_subv_b(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_subv_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_subv_h(0 /* v8i16 */, 0 /* v8i16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_subv_h(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_subv_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_subv_w(0 /* v4i32 */, 0 /* v4i32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_subv_w(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_subv_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_subv_d(0 /* v2i64 */, 0 /* v2i64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_subv_d(0 /* v2i64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_subvi_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_subvi_b::<0>(0 /* v16i8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_subvi_b::<0>(0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_subvi_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_subvi_h::<0>(0 /* v8i16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_subvi_h::<0>(0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_subvi_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_subvi_w::<0>(0 /* v4i32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_subvi_w::<0>(0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_subvi_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_subvi_d::<0>(0 /* v2i64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_subvi_d::<0>(0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_vshf_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_vshf_b(0 /* v16i8 */, 0 /* v16i8 */, 0 /* v16i8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_vshf_b(0 /* v16i8 */, 0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_vshf_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_vshf_h(0 /* v8i16 */, 0 /* v8i16 */, 0 /* v8i16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_vshf_h(0 /* v8i16 */, 0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_vshf_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_vshf_w(0 /* v4i32 */, 0 /* v4i32 */, 0 /* v4i32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_vshf_w(0 /* v4i32 */, 0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_vshf_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_vshf_d(0 /* v2i64 */, 0 /* v2i64 */, 0 /* v2i64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_vshf_d(0 /* v2i64 */, 0 /* v2i64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_xor_v() -> Result<(), String> {
    unsafe {
        let _result = __msa_xor_v(0 /* v16u8 */, 0 /* v16u8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_xor_v(0 /* v16u8 */, 0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_xori_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_xori_b::<0>(0 /* v16u8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_xori_b::<0>(0 /* v16u8 */);
            }
        }
    }
    Ok(())
}
