use std::arch::s390x::*;

#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_s390x_vector_vec_madd() -> Result<(), String> {
    unsafe {
        let _result = vec_madd(0 /* T */, 0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_madd(0 /* T */, 0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_msub() -> Result<(), String> {
    unsafe {
        let _result = vec_msub(0 /* T */, 0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_msub(0 /* T */, 0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_meadd() -> Result<(), String> {
    unsafe {
        let _result = vec_meadd(0 /* T */, 0 /* T */, 0 /* Result */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_meadd(0 /* T */, 0 /* T */, 0 /* Result */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_moadd() -> Result<(), String> {
    unsafe {
        let _result = vec_moadd(0 /* T */, 0 /* T */, 0 /* Result */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_moadd(0 /* T */, 0 /* T */, 0 /* Result */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_mhadd() -> Result<(), String> {
    unsafe {
        let _result = vec_mhadd(0 /* T */, 0 /* T */, 0 /* Result */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_mhadd(0 /* T */, 0 /* T */, 0 /* Result */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_mladd() -> Result<(), String> {
    unsafe {
        let _result = vec_mladd(0 /* T */, 0 /* T */, 0 /* Result */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_mladd(0 /* T */, 0 /* T */, 0 /* Result */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_checksum() -> Result<(), String> {
    unsafe {
        let _result = vec_checksum(0 /* vector_unsigned_int */, 0 /* vector_unsigned_int */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_checksum(0 /* vector_unsigned_int */, 0 /* vector_unsigned_int */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_mule() -> Result<(), String> {
    unsafe {
        let _result = vec_mule(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_mule(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_mulo() -> Result<(), String> {
    unsafe {
        let _result = vec_mulo(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_mulo(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_mulh() -> Result<(), String> {
    unsafe {
        let _result = vec_mulh(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_mulh(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_gfmsum() -> Result<(), String> {
    unsafe {
        let _result = vec_gfmsum(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_gfmsum(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_gfmsum_accum() -> Result<(), String> {
    unsafe {
        let _result = vec_gfmsum_accum(0 /* T */, 0 /* T */, 0 /* Result */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_gfmsum_accum(0 /* T */, 0 /* T */, 0 /* Result */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_gfmsum_128() -> Result<(), String> {
    unsafe {
        let _result = vec_gfmsum_128(0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_long_long */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_gfmsum_128(0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_long_long */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_gfmsum_accum_128() -> Result<(), String> {
    unsafe {
        let _result = vec_gfmsum_accum_128(0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_gfmsum_accum_128(0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_bperm_u128() -> Result<(), String> {
    unsafe {
        let _result = vec_bperm_u128(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_bperm_u128(0 /* vector_unsigned_char */, 0 /* vector_unsigned_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_gather_element() -> Result<(), String> {
    unsafe {
        let _result = vec_gather_element::<0>(0 /* T */, 0 /* Offset */, 0 /* Element */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_gather_element::<0>(0 /* T */, 0 /* Offset */, 0 /* Element */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_sel() -> Result<(), String> {
    unsafe {
        let _result = vec_sel(0 /* T */, 0 /* T */, 0 /* U */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_sel(0 /* T */, 0 /* T */, 0 /* U */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_fp_test_data_class() -> Result<(), String> {
    unsafe {
        let a = 0 /* T */;
        let mut ptr_c = crate::cpu::common::Aligned64([1i32; 16]);
        let _result = vec_fp_test_data_class::<0>(a, ptr_c.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_all_nan() -> Result<(), String> {
    unsafe {
        let result = vec_all_nan(0 /* T */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vec_all_nan(0 /* T */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_all_nan(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_all_numeric() -> Result<(), String> {
    unsafe {
        let result = vec_all_numeric(0 /* T */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vec_all_numeric(0 /* T */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_all_numeric(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_any_nan() -> Result<(), String> {
    unsafe {
        let result = vec_any_nan(0 /* T */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vec_any_nan(0 /* T */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_any_nan(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_any_numeric() -> Result<(), String> {
    unsafe {
        let result = vec_any_numeric(0 /* T */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vec_any_numeric(0 /* T */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_any_numeric(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_test_mask() -> Result<(), String> {
    unsafe {
        let result = vec_test_mask(0 /* T */, 0 /* Mask */);
        check_int_equality(result as i32, 0).map_err(|e| format!("{e} | call: vec_test_mask(0 /* T */, 0 /* Mask */)"))?;

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_test_mask(0 /* T */, 0 /* Mask */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_search_string_cc() -> Result<(), String> {
    unsafe {
        vec_search_string_cc(0 /* T */, 0 /* T */, 0 /* vector_unsigned_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_search_string_cc(0 /* T */, 0 /* T */, 0 /* vector_unsigned_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_search_string_until_zero_cc() -> Result<(), String> {
    unsafe {
        vec_search_string_until_zero_cc(0 /* T */, 0 /* T */, 0 /* vector_unsigned_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_search_string_until_zero_cc(0 /* T */, 0 /* T */, 0 /* vector_unsigned_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_doublee() -> Result<(), String> {
    unsafe {
        let _result = vec_doublee(0 /* vector_float */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_doublee(0 /* vector_float */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_floate() -> Result<(), String> {
    unsafe {
        let _result = vec_floate(0 /* vector_double */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_floate(0 /* vector_double */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_float() -> Result<(), String> {
    unsafe {
        let _result = vec_float(0 /* VectorFloat */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_float(0 /* VectorFloat */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_double() -> Result<(), String> {
    unsafe {
        let _result = vec_double(0 /* VectorDouble */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_double(0 /* VectorDouble */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_extend_s64() -> Result<(), String> {
    unsafe {
        let _result = vec_extend_s64(0 /* VectorExtendSigned64 */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_extend_s64(0 /* VectorExtendSigned64 */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_signed() -> Result<(), String> {
    unsafe {
        let _result = vec_signed(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_signed(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_unsigned() -> Result<(), String> {
    unsafe {
        let _result = vec_unsigned(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_unsigned(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cp_until_zero() -> Result<(), String> {
    unsafe {
        let _result = vec_cp_until_zero(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cp_until_zero(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cp_until_zero_cc() -> Result<(), String> {
    unsafe {
        vec_cp_until_zero_cc(0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                vec_cp_until_zero_cc(0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_msum_u128() -> Result<(), String> {
    unsafe {
        let _result = vec_msum_u128::<0>(0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_char */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_msum_u128::<0>(0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_long_long */, 0 /* vector_unsigned_char */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_sld() -> Result<(), String> {
    unsafe {
        let _result = vec_sld::<0>(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_sld::<0>(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_sldw() -> Result<(), String> {
    unsafe {
        let _result = vec_sldw::<0>(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_sldw::<0>(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_sldb() -> Result<(), String> {
    unsafe {
        let _result = vec_sldb::<0>(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_sldb::<0>(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_srdb() -> Result<(), String> {
    unsafe {
        let _result = vec_srdb::<0>(0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_srdb::<0>(0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmprg() -> Result<(), String> {
    unsafe {
        let _result = vec_cmprg(0 /* T */, 0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cmprg(0 /* T */, 0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmpnrg() -> Result<(), String> {
    unsafe {
        let _result = vec_cmpnrg(0 /* T */, 0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cmpnrg(0 /* T */, 0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmprg_idx() -> Result<(), String> {
    unsafe {
        let _result = vec_cmprg_idx(0 /* T */, 0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cmprg_idx(0 /* T */, 0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmpnrg_idx() -> Result<(), String> {
    unsafe {
        let _result = vec_cmpnrg_idx(0 /* T */, 0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cmpnrg_idx(0 /* T */, 0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmprg_cc() -> Result<(), String> {
    unsafe {
        let a = 0 /* T */;
        let b = 0 /* T */;
        let c = 0 /* T */;
        let mut ptr_d = crate::cpu::common::Aligned64([1i32; 16]);
        let _result = vec_cmprg_cc(a, b, c, ptr_d.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmpnrg_cc() -> Result<(), String> {
    unsafe {
        let a = 0 /* T */;
        let b = 0 /* T */;
        let c = 0 /* T */;
        let mut ptr_d = crate::cpu::common::Aligned64([1i32; 16]);
        let _result = vec_cmpnrg_cc(a, b, c, ptr_d.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmprg_idx_cc() -> Result<(), String> {
    unsafe {
        let a = 0 /* T */;
        let b = 0 /* T */;
        let c = 0 /* T */;
        let mut ptr_d = crate::cpu::common::Aligned64([1i32; 16]);
        let _result = vec_cmprg_idx_cc(a, b, c, ptr_d.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmpnrg_idx_cc() -> Result<(), String> {
    unsafe {
        let a = 0 /* T */;
        let b = 0 /* T */;
        let c = 0 /* T */;
        let mut ptr_d = crate::cpu::common::Aligned64([1i32; 16]);
        let _result = vec_cmpnrg_idx_cc(a, b, c, ptr_d.0.as_mut_ptr());
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmprg_or_0_idx() -> Result<(), String> {
    unsafe {
        let _result = vec_cmprg_or_0_idx(0 /* T */, 0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cmprg_or_0_idx(0 /* T */, 0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmpnrg_or_0_idx() -> Result<(), String> {
    unsafe {
        let _result = vec_cmpnrg_or_0_idx(0 /* T */, 0 /* T */, 0 /* T */);

        let total_iters = crate::cpu::get_iterations();
        if crate::get_fuzzing() && total_iters > 0 {
            log::info!("Starting fuzzing");
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = vec_cmpnrg_or_0_idx(0 /* T */, 0 /* T */, 0 /* T */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_s390x_vector_vec_cmprg_or_0_idx_cc() -> Result<(), String> {
    unsafe {
        let a = 0 /* T */;
        let b = 0 /* T */;
        let c = 0 /* T */;
        let mut ptr_d = crate::cpu::common::Aligned64([1i32; 16]);
        let _result = vec_cmprg_or_0_idx_cc(a, b, c, ptr_d.0.as_mut_ptr());
    }
    Ok(())
}
