use std::arch::powerpc::*;

#[allow(unused_imports)]
use crate::cpu::common::arm::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_vec_vmaddfp() -> Result<(), String> {
    unsafe {
        let _result = vec_vmaddfp(0 /* vector_float */, 0 /* vector_float */, 0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_vmaddfp(0 /* vector_float */, 0 /* vector_float */, 0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_add_bc_sc() -> Result<(), String> {
    unsafe {
        let _result = vec_add_bc_sc(0 /* vector_bool_char */, 0 /* vector_signed_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_add_bc_sc(0 /* vector_bool_char */, 0 /* vector_signed_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_add_sc_sc() -> Result<(), String> {
    unsafe {
        let _result = vec_add_sc_sc(0 /* vector_signed_char */, 0 /* vector_signed_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_add_sc_sc(0 /* vector_signed_char */, 0 /* vector_signed_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_add_bc_uc() -> Result<(), String> {
    unsafe {
        let _result = vec_add_bc_uc(0 /* vector_bool_char */, 0 /* vector_unsigned_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_add_bc_uc(0 /* vector_bool_char */, 0 /* vector_unsigned_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_add_uc_uc() -> Result<(), String> {
    unsafe {
        let _result = vec_add_uc_uc(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_add_uc_uc(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_add_bs_ss() -> Result<(), String> {
    unsafe {
        let _result = vec_add_bs_ss(0 /* vector_bool_short */, 0 /* vector_signed_short */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_add_bs_ss(0 /* vector_bool_short */, 0 /* vector_signed_short */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_add_ss_ss() -> Result<(), String> {
    unsafe {
        let _result = vec_add_ss_ss(0 /* vector_signed_short */, 0 /* vector_signed_short */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_add_ss_ss(0 /* vector_signed_short */, 0 /* vector_signed_short */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_add_bs_us() -> Result<(), String> {
    unsafe {
        let _result = vec_add_bs_us(0 /* vector_bool_short */, 0 /* vector_unsigned_short */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_add_bs_us(0 /* vector_bool_short */, 0 /* vector_unsigned_short */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_add_us_us() -> Result<(), String> {
    unsafe {
        let _result = vec_add_us_us(0 /* vector_unsigned_short */, 0 /* vector_unsigned_short */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_add_us_us(0 /* vector_unsigned_short */, 0 /* vector_unsigned_short */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_add_bi_si() -> Result<(), String> {
    unsafe {
        let _result = vec_add_bi_si(0 /* vector_bool_int */, 0 /* vector_signed_int */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_add_bi_si(0 /* vector_bool_int */, 0 /* vector_signed_int */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_add_si_si() -> Result<(), String> {
    unsafe {
        let _result = vec_add_si_si(0 /* vector_signed_int */, 0 /* vector_signed_int */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_add_si_si(0 /* vector_signed_int */, 0 /* vector_signed_int */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_add_bi_ui() -> Result<(), String> {
    unsafe {
        let _result = vec_add_bi_ui(0 /* vector_bool_int */, 0 /* vector_unsigned_int */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_add_bi_ui(0 /* vector_bool_int */, 0 /* vector_unsigned_int */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_add_ui_ui() -> Result<(), String> {
    unsafe {
        let _result = vec_add_ui_ui(0 /* vector_unsigned_int */, 0 /* vector_unsigned_int */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_add_ui_ui(0 /* vector_unsigned_int */, 0 /* vector_unsigned_int */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_add_float_float() -> Result<(), String> {
    unsafe {
        let _result = vec_add_float_float(0 /* vector_float */, 0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_add_float_float(0 /* vector_float */, 0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_vsel() -> Result<(), String> {
    unsafe {
        let _result = vec_vsel(0 /* vector_signed_char */, 0 /* vector_signed_char */, 0 /* vector_signed_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_vsel(0 /* vector_signed_char */, 0 /* vector_signed_char */, 0 /* vector_signed_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_insert() -> Result<(), String> {
    unsafe {
        vec_insert::<0>(0 /* T */, 0 /* Scalar */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_insert::<0>(0 /* T */, 0 /* Scalar */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_extract() -> Result<(), String> {
    unsafe {
        vec_extract::<0>(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_extract::<0>(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_mergel() -> Result<(), String> {
    unsafe {
        vec_mergel(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_mergel(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_mergeh() -> Result<(), String> {
    unsafe {
        vec_mergeh(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_mergeh(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_pack() -> Result<(), String> {
    unsafe {
        vec_pack(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_pack(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_packs() -> Result<(), String> {
    unsafe {
        vec_packs(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_packs(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_packsu() -> Result<(), String> {
    unsafe {
        vec_packsu(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_packsu(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_unpackh() -> Result<(), String> {
    unsafe {
        vec_unpackh(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_unpackh(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_unpackl() -> Result<(), String> {
    unsafe {
        vec_unpackl(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_unpackl(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_sl() -> Result<(), String> {
    unsafe {
        vec_sl(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_sl(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_sr() -> Result<(), String> {
    unsafe {
        vec_sr(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_sr(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_sra() -> Result<(), String> {
    unsafe {
        vec_sra(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_sra(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_sld() -> Result<(), String> {
    unsafe {
        vec_sld::<0>(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_sld::<0>(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_sldw() -> Result<(), String> {
    unsafe {
        vec_sldw::<0>(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_sldw::<0>(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_sll() -> Result<(), String> {
    unsafe {
        vec_sll(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_sll(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_srl() -> Result<(), String> {
    unsafe {
        vec_srl(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_srl(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_slo() -> Result<(), String> {
    unsafe {
        vec_slo(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_slo(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_sro() -> Result<(), String> {
    unsafe {
        vec_sro(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_sro(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_slv() -> Result<(), String> {
    unsafe {
        let _result = vec_slv(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_slv(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_srv() -> Result<(), String> {
    unsafe {
        let _result = vec_srv(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_srv(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_ld() -> Result<(), String> {
    unsafe {
        vec_ld(0 /* isize */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_ld(0 /* isize */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_ldl() -> Result<(), String> {
    unsafe {
        vec_ldl(0 /* isize */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_ldl(0 /* isize */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_lde() -> Result<(), String> {
    unsafe {
        vec_lde(0 /* isize */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_lde(0 /* isize */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_st() -> Result<(), String> {
    unsafe {
        vec_st(0 /* T */, 0 /* isize */, 0 /* Target */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_st(0 /* T */, 0 /* isize */, 0 /* Target */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_stl() -> Result<(), String> {
    unsafe {
        vec_stl(0 /* T */, 0 /* isize */, 0 /* Target */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_stl(0 /* T */, 0 /* isize */, 0 /* Target */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_ste() -> Result<(), String> {
    unsafe {
        vec_ste(0 /* T */, 0 /* isize */, 0 /* Target */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_ste(0 /* T */, 0 /* isize */, 0 /* Target */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_xl() -> Result<(), String> {
    unsafe {
        vec_xl(0 /* isize */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_xl(0 /* isize */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_xst() -> Result<(), String> {
    unsafe {
        vec_xst(0 /* T */, 0 /* isize */, 0 /* Out */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_xst(0 /* T */, 0 /* isize */, 0 /* Out */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_loge() -> Result<(), String> {
    unsafe {
        let _result = vec_loge(0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_loge(0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_floor() -> Result<(), String> {
    unsafe {
        let _result = vec_floor(0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_floor(0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_expte() -> Result<(), String> {
    unsafe {
        let _result = vec_expte(0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_expte(0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_cmplt() -> Result<(), String> {
    unsafe {
        vec_cmplt(0 /* U */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_cmplt(0 /* U */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_cmple() -> Result<(), String> {
    unsafe {
        let _result = vec_cmple(0 /* vector_float */, 0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cmple(0 /* vector_float */, 0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_cmpgt() -> Result<(), String> {
    unsafe {
        vec_cmpgt(0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_cmpgt(0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_vec_cmpge() -> Result<(), String> {
    unsafe {
        let _result = vec_cmpge(0 /* vector_float */, 0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cmpge(0 /* vector_float */, 0 /* vector_float */);
            }
        }
    }
    Ok(())
}
