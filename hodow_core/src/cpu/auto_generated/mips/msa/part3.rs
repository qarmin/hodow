use std::arch::mips::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mips_msa_msa_bseti_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_bseti_d::<0>(0 /* v2u64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_bseti_d::<0>(0 /* v2u64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_bz_b() -> Result<(), String> {
    unsafe {
        let result = __msa_bz_b(0 /* v16u8 */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: __msa_bz_b(0 /* v16u8 */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_bz_b(0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_bz_h() -> Result<(), String> {
    unsafe {
        let result = __msa_bz_h(0 /* v8u16 */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: __msa_bz_h(0 /* v8u16 */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_bz_h(0 /* v8u16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_bz_w() -> Result<(), String> {
    unsafe {
        let result = __msa_bz_w(0 /* v4u32 */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: __msa_bz_w(0 /* v4u32 */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_bz_w(0 /* v4u32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_bz_d() -> Result<(), String> {
    unsafe {
        let result = __msa_bz_d(0 /* v2u64 */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: __msa_bz_d(0 /* v2u64 */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_bz_d(0 /* v2u64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_bz_v() -> Result<(), String> {
    unsafe {
        let result = __msa_bz_v(0 /* v16u8 */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: __msa_bz_v(0 /* v16u8 */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_bz_v(0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ceq_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_ceq_b(0 /* v16i8 */, 0 /* v16i8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ceq_b(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ceq_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_ceq_h(0 /* v8i16 */, 0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ceq_h(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ceq_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_ceq_w(0 /* v4i32 */, 0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ceq_w(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ceq_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_ceq_d(0 /* v2i64 */, 0 /* v2i64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ceq_d(0 /* v2i64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ceqi_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_ceqi_b::<0>(0 /* v16i8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ceqi_b::<0>(0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ceqi_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_ceqi_h::<0>(0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ceqi_h::<0>(0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ceqi_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_ceqi_w::<0>(0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ceqi_w::<0>(0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_ceqi_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_ceqi_d::<0>(0 /* v2i64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ceqi_d::<0>(0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_cfcmsa() -> Result<(), String> {
    unsafe {
        let result = __msa_cfcmsa::<0>();
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: __msa_cfcmsa::<0>()"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_cfcmsa::<0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_cle_s_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_cle_s_b(0 /* v16i8 */, 0 /* v16i8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_cle_s_b(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_cle_s_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_cle_s_h(0 /* v8i16 */, 0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_cle_s_h(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_cle_s_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_cle_s_w(0 /* v4i32 */, 0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_cle_s_w(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_cle_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_cle_s_d(0 /* v2i64 */, 0 /* v2i64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_cle_s_d(0 /* v2i64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_cle_u_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_cle_u_b(0 /* v16u8 */, 0 /* v16u8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_cle_u_b(0 /* v16u8 */, 0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_cle_u_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_cle_u_h(0 /* v8u16 */, 0 /* v8u16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_cle_u_h(0 /* v8u16 */, 0 /* v8u16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_cle_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_cle_u_w(0 /* v4u32 */, 0 /* v4u32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_cle_u_w(0 /* v4u32 */, 0 /* v4u32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_cle_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_cle_u_d(0 /* v2u64 */, 0 /* v2u64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_cle_u_d(0 /* v2u64 */, 0 /* v2u64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clei_s_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_clei_s_b::<0>(0 /* v16i8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clei_s_b::<0>(0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clei_s_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_clei_s_h::<0>(0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clei_s_h::<0>(0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clei_s_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_clei_s_w::<0>(0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clei_s_w::<0>(0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clei_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_clei_s_d::<0>(0 /* v2i64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clei_s_d::<0>(0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clei_u_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_clei_u_b::<0>(0 /* v16u8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clei_u_b::<0>(0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clei_u_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_clei_u_h::<0>(0 /* v8u16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clei_u_h::<0>(0 /* v8u16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clei_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_clei_u_w::<0>(0 /* v4u32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clei_u_w::<0>(0 /* v4u32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clei_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_clei_u_d::<0>(0 /* v2u64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clei_u_d::<0>(0 /* v2u64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clt_s_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_clt_s_b(0 /* v16i8 */, 0 /* v16i8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clt_s_b(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clt_s_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_clt_s_h(0 /* v8i16 */, 0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clt_s_h(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clt_s_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_clt_s_w(0 /* v4i32 */, 0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clt_s_w(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clt_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_clt_s_d(0 /* v2i64 */, 0 /* v2i64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clt_s_d(0 /* v2i64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clt_u_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_clt_u_b(0 /* v16u8 */, 0 /* v16u8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clt_u_b(0 /* v16u8 */, 0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clt_u_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_clt_u_h(0 /* v8u16 */, 0 /* v8u16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clt_u_h(0 /* v8u16 */, 0 /* v8u16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clt_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_clt_u_w(0 /* v4u32 */, 0 /* v4u32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clt_u_w(0 /* v4u32 */, 0 /* v4u32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clt_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_clt_u_d(0 /* v2u64 */, 0 /* v2u64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clt_u_d(0 /* v2u64 */, 0 /* v2u64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clti_s_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_clti_s_b::<0>(0 /* v16i8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clti_s_b::<0>(0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clti_s_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_clti_s_h::<0>(0 /* v8i16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clti_s_h::<0>(0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clti_s_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_clti_s_w::<0>(0 /* v4i32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clti_s_w::<0>(0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clti_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_clti_s_d::<0>(0 /* v2i64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clti_s_d::<0>(0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clti_u_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_clti_u_b::<0>(0 /* v16u8 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clti_u_b::<0>(0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clti_u_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_clti_u_h::<0>(0 /* v8u16 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clti_u_h::<0>(0 /* v8u16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clti_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_clti_u_w::<0>(0 /* v4u32 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clti_u_w::<0>(0 /* v4u32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_clti_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_clti_u_d::<0>(0 /* v2u64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_clti_u_d::<0>(0 /* v2u64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_copy_s_b() -> Result<(), String> {
    unsafe {
        let result = __msa_copy_s_b::<0>(0 /* v16i8 */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: __msa_copy_s_b::<0>(0 /* v16i8 */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_copy_s_b::<0>(0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_copy_s_h() -> Result<(), String> {
    unsafe {
        let result = __msa_copy_s_h::<0>(0 /* v8i16 */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: __msa_copy_s_h::<0>(0 /* v8i16 */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_copy_s_h::<0>(0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mips_msa_msa_copy_s_w() -> Result<(), String> {
    unsafe {
        let result = __msa_copy_s_w::<0>(0 /* v4i32 */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: __msa_copy_s_w::<0>(0 /* v4i32 */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_copy_s_w::<0>(0 /* v4i32 */);
            }
        }
    }
    Ok(())
}
