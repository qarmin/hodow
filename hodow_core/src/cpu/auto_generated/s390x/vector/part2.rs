use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_vec_rl() -> Result<(), String> {
    unsafe {
        let _result = vec_rl(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_rl(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_sll() -> Result<(), String> {
    unsafe {
        vec_sll(0 /* T */, 0 /* vector_unsigned_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_sll(0 /* T */, 0 /* vector_unsigned_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_srl() -> Result<(), String> {
    unsafe {
        vec_srl(0 /* T */, 0 /* vector_unsigned_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_srl(0 /* T */, 0 /* vector_unsigned_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_sral() -> Result<(), String> {
    unsafe {
        vec_sral(0 /* T */, 0 /* vector_unsigned_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_sral(0 /* T */, 0 /* vector_unsigned_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_rli() -> Result<(), String> {
    unsafe {
        let _result = vec_rli(0 /* T */, 0 /* c_ulong */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_rli(0 /* T */, 0 /* c_ulong */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_reve() -> Result<(), String> {
    unsafe {
        let _result = vec_reve(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_reve(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_revb() -> Result<(), String> {
    unsafe {
        let _result = vec_revb(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_revb(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_mergeh() -> Result<(), String> {
    unsafe {
        let _result = vec_mergeh(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_mergeh(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_mergel() -> Result<(), String> {
    unsafe {
        let _result = vec_mergel(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_mergel(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_pack() -> Result<(), String> {
    unsafe {
        let _result = vec_pack(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_pack(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_packs() -> Result<(), String> {
    unsafe {
        let _result = vec_packs(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_packs(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_packs_cc() -> Result<(), String> {
    unsafe {
        vec_packs_cc(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_packs_cc(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_packsu() -> Result<(), String> {
    unsafe {
        let _result = vec_packsu(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_packsu(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_packsu_cc() -> Result<(), String> {
    unsafe {
        vec_packsu_cc(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_packsu_cc(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_unpackh() -> Result<(), String> {
    unsafe {
        let _result = vec_unpackh(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_unpackh(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_unpackl() -> Result<(), String> {
    unsafe {
        let _result = vec_unpackl(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_unpackl(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_genmask() -> Result<(), String> {
    unsafe {
        let _result = vec_genmask::<0>();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_genmask::<0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_genmasks_8() -> Result<(), String> {
    unsafe {
        let _result = vec_genmasks_8::<0, 0>();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_genmasks_8::<0, 0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_genmasks_16() -> Result<(), String> {
    unsafe {
        let _result = vec_genmasks_16::<0, 0>();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_genmasks_16::<0, 0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_genmasks_32() -> Result<(), String> {
    unsafe {
        let _result = vec_genmasks_32::<0, 0>();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_genmasks_32::<0, 0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_genmasks_64() -> Result<(), String> {
    unsafe {
        let _result = vec_genmasks_64::<0, 0>();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_genmasks_64::<0, 0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_perm() -> Result<(), String> {
    unsafe {
        let _result = vec_perm(0 /* T */, 0 /* T */, 0 /* vector_unsigned_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_perm(0 /* T */, 0 /* T */, 0 /* vector_unsigned_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_sum_u128() -> Result<(), String> {
    unsafe {
        let _result = vec_sum_u128(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_sum_u128(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_sum2() -> Result<(), String> {
    unsafe {
        let _result = vec_sum2(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_sum2(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_sum4() -> Result<(), String> {
    unsafe {
        let _result = vec_sum4(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_sum4(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_add_u128() -> Result<(), String> {
    unsafe {
        let _result = vec_add_u128(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_add_u128(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_sub_u128() -> Result<(), String> {
    unsafe {
        let _result = vec_sub_u128(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_sub_u128(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_subc() -> Result<(), String> {
    unsafe {
        let _result = vec_subc(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_subc(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_subc_u128() -> Result<(), String> {
    unsafe {
        let _result = vec_subc_u128(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_subc_u128(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_addc_u128() -> Result<(), String> {
    unsafe {
        let _result = vec_addc_u128(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_addc_u128(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_adde_u128() -> Result<(), String> {
    unsafe {
        let _result = vec_adde_u128(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_adde_u128(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_addec_u128() -> Result<(), String> {
    unsafe {
        let _result = vec_addec_u128(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_addec_u128(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_sube_u128() -> Result<(), String> {
    unsafe {
        let _result = vec_sube_u128(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_sube_u128(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_subec_u128() -> Result<(), String> {
    unsafe {
        let _result = vec_subec_u128(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_subec_u128(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_splat_s8() -> Result<(), String> {
    unsafe {
        let _result = vec_splat_s8::<0>();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_splat_s8::<0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_splat_s16() -> Result<(), String> {
    unsafe {
        let _result = vec_splat_s16::<0>();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_splat_s16::<0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_splat_s32() -> Result<(), String> {
    unsafe {
        let _result = vec_splat_s32::<0>();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_splat_s32::<0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_splat_s64() -> Result<(), String> {
    unsafe {
        let _result = vec_splat_s64::<0>();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_splat_s64::<0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_splat_u8() -> Result<(), String> {
    unsafe {
        let _result = vec_splat_u8::<0>();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_splat_u8::<0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_splat_u16() -> Result<(), String> {
    unsafe {
        let _result = vec_splat_u16::<0>();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_splat_u16::<0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_splat_u32() -> Result<(), String> {
    unsafe {
        let _result = vec_splat_u32::<0>();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_splat_u32::<0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_splat_u64() -> Result<(), String> {
    unsafe {
        let _result = vec_splat_u64::<0>();

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_splat_u64::<0>();
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_xl() -> Result<(), String> {
    unsafe {
        let _result = vec_xl(0 /* isize */, 0 /* ElementType */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_xl(0 /* isize */, 0 /* ElementType */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_load_pair() -> Result<(), String> {
    unsafe {
        let _result = vec_load_pair(0 /* ElementType */, 0 /* ElementType */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_load_pair(0 /* ElementType */, 0 /* ElementType */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_load_bndry() -> Result<(), String> {
    unsafe {
        let _result = vec_load_bndry::<0>(0 /* ElementType */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_load_bndry::<0>(0 /* ElementType */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_xst() -> Result<(), String> {
    unsafe {
        vec_xst(0 /* T */, 0 /* isize */, 0 /* ElementType */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_xst(0 /* T */, 0 /* isize */, 0 /* ElementType */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_load_len() -> Result<(), String> {
    unsafe {
        let _result = vec_load_len(0 /* ElementType */, 1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_load_len(0 /* ElementType */, rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_store_len() -> Result<(), String> {
    unsafe {
        vec_store_len(0 /* T */, 0 /* ElementType */, 1u32);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_store_len(0 /* T */, 0 /* ElementType */, rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_load_len_r() -> Result<(), String> {
    unsafe {
        let ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let byte_count = 2u32;
        let _result = vec_load_len_r(ptr_ptr.0.as_ptr(), byte_count);
    }
    Ok(())
}

pub(super) fn test_vec_store_len_r() -> Result<(), String> {
    unsafe {
        let vector = 0 /* vector_unsigned_char */;
        let mut ptr_ptr = crate::cpu::common::Aligned64([1u8; 64]);
        let byte_count = 2u32;
        vec_store_len_r(vector, ptr_ptr.0.as_mut_ptr(), byte_count);
    }
    Ok(())
}
