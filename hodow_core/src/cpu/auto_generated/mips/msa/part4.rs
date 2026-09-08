use std::arch::mips::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mips_msa_msa_copy_s_d() -> Result<(), String> {
    unsafe {
        let result = __msa_copy_s_d::<0>(0 /* v2i64 */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: __msa_copy_s_d::<0>(0 /* v2i64 */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_copy_s_d::<0>(0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_copy_u_b() -> Result<(), String> {
    unsafe {
        let result = __msa_copy_u_b::<0>(0 /* v16i8 */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: __msa_copy_u_b::<0>(0 /* v16i8 */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_copy_u_b::<0>(0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_copy_u_h() -> Result<(), String> {
    unsafe {
        let result = __msa_copy_u_h::<0>(0 /* v8i16 */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: __msa_copy_u_h::<0>(0 /* v8i16 */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_copy_u_h::<0>(0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_copy_u_w() -> Result<(), String> {
    unsafe {
        let result = __msa_copy_u_w::<0>(0 /* v4i32 */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: __msa_copy_u_w::<0>(0 /* v4i32 */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_copy_u_w::<0>(0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_copy_u_d() -> Result<(), String> {
    unsafe {
        let result = __msa_copy_u_d::<0>(0 /* v2i64 */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: __msa_copy_u_d::<0>(0 /* v2i64 */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_copy_u_d::<0>(0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ctcmsa() -> Result<(), String> {
    unsafe {
        __msa_ctcmsa::<0>(1i32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                __msa_ctcmsa::<0>(rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_div_s_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_div_s_b(0 /* v16i8 */, 0 /* v16i8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_div_s_b(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_div_s_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_div_s_h(0 /* v8i16 */, 0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_div_s_h(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_div_s_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_div_s_w(0 /* v4i32 */, 0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_div_s_w(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_div_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_div_s_d(0 /* v2i64 */, 0 /* v2i64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_div_s_d(0 /* v2i64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_div_u_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_div_u_b(0 /* v16u8 */, 0 /* v16u8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_div_u_b(0 /* v16u8 */, 0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_div_u_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_div_u_h(0 /* v8u16 */, 0 /* v8u16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_div_u_h(0 /* v8u16 */, 0 /* v8u16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_div_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_div_u_w(0 /* v4u32 */, 0 /* v4u32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_div_u_w(0 /* v4u32 */, 0 /* v4u32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_div_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_div_u_d(0 /* v2u64 */, 0 /* v2u64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_div_u_d(0 /* v2u64 */, 0 /* v2u64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_dotp_s_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_dotp_s_h(0 /* v16i8 */, 0 /* v16i8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_dotp_s_h(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_dotp_s_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_dotp_s_w(0 /* v8i16 */, 0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_dotp_s_w(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_dotp_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_dotp_s_d(0 /* v4i32 */, 0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_dotp_s_d(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_dotp_u_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_dotp_u_h(0 /* v16u8 */, 0 /* v16u8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_dotp_u_h(0 /* v16u8 */, 0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_dotp_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_dotp_u_w(0 /* v8u16 */, 0 /* v8u16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_dotp_u_w(0 /* v8u16 */, 0 /* v8u16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_dotp_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_dotp_u_d(0 /* v4u32 */, 0 /* v4u32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_dotp_u_d(0 /* v4u32 */, 0 /* v4u32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_dpadd_s_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_dpadd_s_h(0 /* v8i16 */, 0 /* v16i8 */, 0 /* v16i8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_dpadd_s_h(0 /* v8i16 */, 0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_dpadd_s_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_dpadd_s_w(0 /* v4i32 */, 0 /* v8i16 */, 0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_dpadd_s_w(0 /* v4i32 */, 0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_dpadd_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_dpadd_s_d(0 /* v2i64 */, 0 /* v4i32 */, 0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_dpadd_s_d(0 /* v2i64 */, 0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_dpadd_u_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_dpadd_u_h(0 /* v8u16 */, 0 /* v16u8 */, 0 /* v16u8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_dpadd_u_h(0 /* v8u16 */, 0 /* v16u8 */, 0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_dpadd_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_dpadd_u_w(0 /* v4u32 */, 0 /* v8u16 */, 0 /* v8u16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_dpadd_u_w(0 /* v4u32 */, 0 /* v8u16 */, 0 /* v8u16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_dpadd_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_dpadd_u_d(0 /* v2u64 */, 0 /* v4u32 */, 0 /* v4u32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_dpadd_u_d(0 /* v2u64 */, 0 /* v4u32 */, 0 /* v4u32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_dpsub_s_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_dpsub_s_h(0 /* v8i16 */, 0 /* v16i8 */, 0 /* v16i8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_dpsub_s_h(0 /* v8i16 */, 0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_dpsub_s_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_dpsub_s_w(0 /* v4i32 */, 0 /* v8i16 */, 0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_dpsub_s_w(0 /* v4i32 */, 0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_dpsub_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_dpsub_s_d(0 /* v2i64 */, 0 /* v4i32 */, 0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_dpsub_s_d(0 /* v2i64 */, 0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_dpsub_u_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_dpsub_u_h(0 /* v8i16 */, 0 /* v16u8 */, 0 /* v16u8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_dpsub_u_h(0 /* v8i16 */, 0 /* v16u8 */, 0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_dpsub_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_dpsub_u_w(0 /* v4i32 */, 0 /* v8u16 */, 0 /* v8u16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_dpsub_u_w(0 /* v4i32 */, 0 /* v8u16 */, 0 /* v8u16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_dpsub_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_dpsub_u_d(0 /* v2i64 */, 0 /* v4u32 */, 0 /* v4u32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_dpsub_u_d(0 /* v2i64 */, 0 /* v4u32 */, 0 /* v4u32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fadd_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fadd_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fadd_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fadd_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fadd_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fadd_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fcaf_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fcaf_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fcaf_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fcaf_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fcaf_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fcaf_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fceq_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fceq_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fceq_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fceq_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fceq_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fceq_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fclass_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fclass_w(0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fclass_w(0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fclass_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fclass_d(0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fclass_d(0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fcle_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fcle_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fcle_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fcle_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fcle_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fcle_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fclt_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fclt_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fclt_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fclt_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fclt_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fclt_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fcne_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fcne_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fcne_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fcne_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fcne_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fcne_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fcor_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fcor_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fcor_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fcor_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fcor_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fcor_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fcueq_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_fcueq_w(0 /* v4f32 */, 0 /* v4f32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fcueq_w(0 /* v4f32 */, 0 /* v4f32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_fcueq_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_fcueq_d(0 /* v2f64 */, 0 /* v2f64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_fcueq_d(0 /* v2f64 */, 0 /* v2f64 */);
            }
        }
    }
    Ok(())
}
