use std::arch::mips::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_msa_maxi_s_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_maxi_s_h::<0>(0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_maxi_s_h::<0>(0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_maxi_s_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_maxi_s_w::<0>(0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_maxi_s_w::<0>(0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_maxi_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_maxi_s_d::<0>(0 /* v2i64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_maxi_s_d::<0>(0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_maxi_u_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_maxi_u_b::<0>(0 /* v16u8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_maxi_u_b::<0>(0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_maxi_u_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_maxi_u_h::<0>(0 /* v8u16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_maxi_u_h::<0>(0 /* v8u16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_maxi_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_maxi_u_w::<0>(0 /* v4u32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_maxi_u_w::<0>(0 /* v4u32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_maxi_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_maxi_u_d::<0>(0 /* v2u64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_maxi_u_d::<0>(0 /* v2u64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_min_a_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_min_a_b(0 /* v16i8 */, 0 /* v16i8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_min_a_b(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_min_a_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_min_a_h(0 /* v8i16 */, 0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_min_a_h(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_min_a_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_min_a_w(0 /* v4i32 */, 0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_min_a_w(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_min_a_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_min_a_d(0 /* v2i64 */, 0 /* v2i64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_min_a_d(0 /* v2i64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_min_s_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_min_s_b(0 /* v16i8 */, 0 /* v16i8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_min_s_b(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_min_s_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_min_s_h(0 /* v8i16 */, 0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_min_s_h(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_min_s_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_min_s_w(0 /* v4i32 */, 0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_min_s_w(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_min_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_min_s_d(0 /* v2i64 */, 0 /* v2i64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_min_s_d(0 /* v2i64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_mini_s_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_mini_s_b::<0>(0 /* v16i8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mini_s_b::<0>(0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_mini_s_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_mini_s_h::<0>(0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mini_s_h::<0>(0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_mini_s_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_mini_s_w::<0>(0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mini_s_w::<0>(0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_mini_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_mini_s_d::<0>(0 /* v2i64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mini_s_d::<0>(0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_min_u_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_min_u_b(0 /* v16u8 */, 0 /* v16u8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_min_u_b(0 /* v16u8 */, 0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_min_u_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_min_u_h(0 /* v8u16 */, 0 /* v8u16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_min_u_h(0 /* v8u16 */, 0 /* v8u16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_min_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_min_u_w(0 /* v4u32 */, 0 /* v4u32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_min_u_w(0 /* v4u32 */, 0 /* v4u32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_min_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_min_u_d(0 /* v2u64 */, 0 /* v2u64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_min_u_d(0 /* v2u64 */, 0 /* v2u64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_mini_u_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_mini_u_b::<0>(0 /* v16u8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mini_u_b::<0>(0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_mini_u_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_mini_u_h::<0>(0 /* v8u16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mini_u_h::<0>(0 /* v8u16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_mini_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_mini_u_w::<0>(0 /* v4u32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mini_u_w::<0>(0 /* v4u32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_mini_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_mini_u_d::<0>(0 /* v2u64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mini_u_d::<0>(0 /* v2u64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_mod_s_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_mod_s_b(0 /* v16i8 */, 0 /* v16i8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mod_s_b(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_mod_s_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_mod_s_h(0 /* v8i16 */, 0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mod_s_h(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_mod_s_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_mod_s_w(0 /* v4i32 */, 0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mod_s_w(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_mod_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_mod_s_d(0 /* v2i64 */, 0 /* v2i64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mod_s_d(0 /* v2i64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_mod_u_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_mod_u_b(0 /* v16u8 */, 0 /* v16u8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mod_u_b(0 /* v16u8 */, 0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_mod_u_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_mod_u_h(0 /* v8u16 */, 0 /* v8u16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mod_u_h(0 /* v8u16 */, 0 /* v8u16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_mod_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_mod_u_w(0 /* v4u32 */, 0 /* v4u32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mod_u_w(0 /* v4u32 */, 0 /* v4u32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_mod_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_mod_u_d(0 /* v2u64 */, 0 /* v2u64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mod_u_d(0 /* v2u64 */, 0 /* v2u64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_move_v() -> Result<(), String> {
    unsafe {
        let _result = __msa_move_v(0 /* v16i8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_move_v(0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_msub_q_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_msub_q_h(0 /* v8i16 */, 0 /* v8i16 */, 0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_msub_q_h(0 /* v8i16 */, 0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_msub_q_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_msub_q_w(0 /* v4i32 */, 0 /* v4i32 */, 0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_msub_q_w(0 /* v4i32 */, 0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_msubr_q_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_msubr_q_h(0 /* v8i16 */, 0 /* v8i16 */, 0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_msubr_q_h(0 /* v8i16 */, 0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_msubr_q_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_msubr_q_w(0 /* v4i32 */, 0 /* v4i32 */, 0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_msubr_q_w(0 /* v4i32 */, 0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_msubv_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_msubv_b(0 /* v16i8 */, 0 /* v16i8 */, 0 /* v16i8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_msubv_b(0 /* v16i8 */, 0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_msubv_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_msubv_h(0 /* v8i16 */, 0 /* v8i16 */, 0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_msubv_h(0 /* v8i16 */, 0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_msubv_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_msubv_w(0 /* v4i32 */, 0 /* v4i32 */, 0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_msubv_w(0 /* v4i32 */, 0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_msubv_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_msubv_d(0 /* v2i64 */, 0 /* v2i64 */, 0 /* v2i64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_msubv_d(0 /* v2i64 */, 0 /* v2i64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_mul_q_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_mul_q_h(0 /* v8i16 */, 0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mul_q_h(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_mul_q_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_mul_q_w(0 /* v4i32 */, 0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mul_q_w(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_mulr_q_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_mulr_q_h(0 /* v8i16 */, 0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mulr_q_h(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_mulr_q_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_mulr_q_w(0 /* v4i32 */, 0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mulr_q_w(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_mulv_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_mulv_b(0 /* v16i8 */, 0 /* v16i8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mulv_b(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_mulv_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_mulv_h(0 /* v8i16 */, 0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mulv_h(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}
