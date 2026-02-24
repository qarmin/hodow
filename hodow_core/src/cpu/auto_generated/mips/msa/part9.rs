use std::arch::mips::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_msa_mulv_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_mulv_w(0 /* v4i32 */, 0 /* v4i32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mulv_w(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_mulv_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_mulv_d(0 /* v2i64 */, 0 /* v2i64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_mulv_d(0 /* v2i64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_nloc_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_nloc_b(0 /* v16i8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_nloc_b(0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_nloc_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_nloc_h(0 /* v8i16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_nloc_h(0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_nloc_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_nloc_w(0 /* v4i32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_nloc_w(0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_nloc_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_nloc_d(0 /* v2i64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_nloc_d(0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_nlzc_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_nlzc_b(0 /* v16i8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_nlzc_b(0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_nlzc_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_nlzc_h(0 /* v8i16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_nlzc_h(0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_nlzc_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_nlzc_w(0 /* v4i32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_nlzc_w(0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_nlzc_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_nlzc_d(0 /* v2i64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_nlzc_d(0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_nor_v() -> Result<(), String> {
    unsafe {
        let _result = __msa_nor_v(0 /* v16u8 */, 0 /* v16u8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_nor_v(0 /* v16u8 */, 0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_nori_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_nori_b::<0>(0 /* v16u8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_nori_b::<0>(0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_or_v() -> Result<(), String> {
    unsafe {
        let _result = __msa_or_v(0 /* v16u8 */, 0 /* v16u8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_or_v(0 /* v16u8 */, 0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_ori_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_ori_b::<0>(0 /* v16u8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_ori_b::<0>(0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_pckev_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_pckev_b(0 /* v16i8 */, 0 /* v16i8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_pckev_b(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_pckev_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_pckev_h(0 /* v8i16 */, 0 /* v8i16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_pckev_h(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_pckev_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_pckev_w(0 /* v4i32 */, 0 /* v4i32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_pckev_w(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_pckev_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_pckev_d(0 /* v2i64 */, 0 /* v2i64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_pckev_d(0 /* v2i64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_pckod_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_pckod_b(0 /* v16i8 */, 0 /* v16i8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_pckod_b(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_pckod_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_pckod_h(0 /* v8i16 */, 0 /* v8i16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_pckod_h(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_pckod_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_pckod_w(0 /* v4i32 */, 0 /* v4i32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_pckod_w(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_pckod_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_pckod_d(0 /* v2i64 */, 0 /* v2i64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_pckod_d(0 /* v2i64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_pcnt_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_pcnt_b(0 /* v16i8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_pcnt_b(0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_pcnt_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_pcnt_h(0 /* v8i16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_pcnt_h(0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_pcnt_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_pcnt_w(0 /* v4i32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_pcnt_w(0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_pcnt_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_pcnt_d(0 /* v2i64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_pcnt_d(0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_sat_s_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_sat_s_b::<0>(0 /* v16i8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_sat_s_b::<0>(0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_sat_s_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_sat_s_h::<0>(0 /* v8i16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_sat_s_h::<0>(0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_sat_s_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_sat_s_w::<0>(0 /* v4i32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_sat_s_w::<0>(0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_sat_s_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_sat_s_d::<0>(0 /* v2i64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_sat_s_d::<0>(0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_sat_u_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_sat_u_b::<0>(0 /* v16u8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_sat_u_b::<0>(0 /* v16u8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_sat_u_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_sat_u_h::<0>(0 /* v8u16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_sat_u_h::<0>(0 /* v8u16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_sat_u_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_sat_u_w::<0>(0 /* v4u32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_sat_u_w::<0>(0 /* v4u32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_sat_u_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_sat_u_d::<0>(0 /* v2u64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_sat_u_d::<0>(0 /* v2u64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_shf_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_shf_b::<0>(0 /* v16i8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_shf_b::<0>(0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_shf_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_shf_h::<0>(0 /* v8i16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_shf_h::<0>(0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_shf_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_shf_w::<0>(0 /* v4i32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_shf_w::<0>(0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_sld_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_sld_b(0 /* v16i8 */, 0 /* v16i8 */, 1i32);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_sld_b(0 /* v16i8 */, 0 /* v16i8 */, rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_sld_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_sld_h(0 /* v8i16 */, 0 /* v8i16 */, 1i32);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_sld_h(0 /* v8i16 */, 0 /* v8i16 */, rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_sld_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_sld_w(0 /* v4i32 */, 0 /* v4i32 */, 1i32);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_sld_w(0 /* v4i32 */, 0 /* v4i32 */, rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_sld_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_sld_d(0 /* v2i64 */, 0 /* v2i64 */, 1i32);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_sld_d(0 /* v2i64 */, 0 /* v2i64 */, rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_sldi_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_sldi_b::<0>(0 /* v16i8 */, 0 /* v16i8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_sldi_b::<0>(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_sldi_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_sldi_h::<0>(0 /* v8i16 */, 0 /* v8i16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_sldi_h::<0>(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_sldi_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_sldi_w::<0>(0 /* v4i32 */, 0 /* v4i32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_sldi_w::<0>(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_sldi_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_sldi_d::<0>(0 /* v2i64 */, 0 /* v2i64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_sldi_d::<0>(0 /* v2i64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_sll_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_sll_b(0 /* v16i8 */, 0 /* v16i8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_sll_b(0 /* v16i8 */, 0 /* v16i8 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_sll_h() -> Result<(), String> {
    unsafe {
        let _result = __msa_sll_h(0 /* v8i16 */, 0 /* v8i16 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_sll_h(0 /* v8i16 */, 0 /* v8i16 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_sll_w() -> Result<(), String> {
    unsafe {
        let _result = __msa_sll_w(0 /* v4i32 */, 0 /* v4i32 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_sll_w(0 /* v4i32 */, 0 /* v4i32 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_sll_d() -> Result<(), String> {
    unsafe {
        let _result = __msa_sll_d(0 /* v2i64 */, 0 /* v2i64 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_sll_d(0 /* v2i64 */, 0 /* v2i64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_msa_slli_b() -> Result<(), String> {
    unsafe {
        let _result = __msa_slli_b::<0>(0 /* v16i8 */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = __msa_slli_b::<0>(0 /* v16i8 */);
            }
        }
    }
    Ok(())
}
