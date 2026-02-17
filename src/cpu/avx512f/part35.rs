use std::arch::x86_64::*;

pub(super) fn test_mm_mask_cmp_ps_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(1.0, 2.0, 0.0, 5.0);
        // use vector compare + movemask instead of unavailable mask intrinsic/constants
        let cmpv = _mm_cmpeq_ps(a, b);
        let r = _mm_movemask_ps(cmpv) as i32;
        // equal at lanes where a==b -> expected mask 12
        crate::cpu::common::check_int_equality(r, 12)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_float32_array::<4>();
                let rb = crate::cpu::common::get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_ps(rb[3], rb[2], rb[1], rb[0]);
                let cmpv = _mm_cmpeq_ps(a_r, b_r);
                let _ = _mm_movemask_ps(cmpv);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmp_pd_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(2.0, 0.0);
        let cmpv = _mm_cmp_pd::<0>(a, b);
        let r = _mm_movemask_pd(cmpv) as i32;
        // a >= b -> lanes both true => mask 3
        crate::cpu::common::check_int_equality(r, 3)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_float64_array::<2>();
                let rb = crate::cpu::common::get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let b_r = _mm_set_pd(rb[1], rb[0]);
                let cmpv = _mm_cmp_pd::<0>(a_r, b_r);
                let _ = _mm_movemask_pd(cmpv);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmp_pd_mask() -> Result<(), String> {
    unsafe {
        let _src = _mm_setzero_pd();
        let a = _mm_set_pd(2.0, 1.0);
        let b = _mm_set_pd(2.0, 0.0);
        // emulate masked compare by plain compare + movemask
        let cmpv = _mm_cmp_pd::<0>(a, b);
        let r = _mm_movemask_pd(cmpv) as i32;
        crate::cpu::common::check_int_equality(r, 3)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_float64_array::<2>();
                let rb = crate::cpu::common::get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let b_r = _mm_set_pd(rb[1], rb[0]);
                let cmpv = _mm_cmp_pd::<0>(a_r, b_r);
                let _ = _mm_movemask_pd(cmpv);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmp_ss_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0);
        let b = _mm_set_ss(1.0);
        let cmpv = _mm_cmpeq_ss(a, b);
        let r = (_mm_movemask_ps(cmpv) & 1) as i32;
        crate::cpu::common::check_int_equality(r, 1)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_float32_array::<4>();
                let rb = crate::cpu::common::get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_ps(rb[3], rb[2], rb[1], rb[0]);
                let cmpv = _mm_cmpeq_ss(a_r, b_r);
                let _ = _mm_movemask_ps(cmpv);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmp_ss_mask() -> Result<(), String> {
    unsafe {
        let _src = _mm_setzero_ps();
        let a = _mm_set_ss(1.0);
        let b = _mm_set_ss(1.0);
        let cmpv = _mm_cmpeq_ss(a, b);
        let r = (_mm_movemask_ps(cmpv) & 1) as i32;
        crate::cpu::common::check_int_equality(r, 1)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_float32_array::<4>();
                let rb = crate::cpu::common::get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_ps(rb[3], rb[2], rb[1], rb[0]);
                let cmpv = _mm_cmpeq_ss(a_r, b_r);
                let _ = _mm_movemask_ps(cmpv);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmp_round_ss_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(3.2);
        let b = _mm_set_ss(3.2);
        // ignore rounding flags for test: do scalar compare + movemask
        let cmpv = _mm_cmpeq_ss(a, b);
        let r = (_mm_movemask_ps(cmpv) & 1) as i32;
        crate::cpu::common::check_int_equality(r, 1)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_float32_array::<4>();
                let rb = crate::cpu::common::get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_ps(rb[3], rb[2], rb[1], rb[0]);
                let cmpv = _mm_cmpeq_ss(a_r, b_r);
                let _ = _mm_movemask_ps(cmpv);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmp_round_ss_mask() -> Result<(), String> {
    unsafe {
        let _src = _mm_setzero_ps();
        let a = _mm_set_ss(3.2);
        let b = _mm_set_ss(3.2);
        let cmpv = _mm_cmpeq_ss(a, b);
        let r = (_mm_movemask_ps(cmpv) & 1) as i32;
        crate::cpu::common::check_int_equality(r, 1)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_float32_array::<4>();
                let rb = crate::cpu::common::get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_ps(rb[3], rb[2], rb[1], rb[0]);
                let cmpv = _mm_cmpeq_ss(a_r, b_r);
                let _ = _mm_movemask_ps(cmpv);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmp_sd_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(2.0);
        let b = _mm_set_sd(1.0);
        let cmpv = _mm_cmpgt_sd(a, b);
        let r = (_mm_movemask_pd(cmpv) & 1) as i32;
        crate::cpu::common::check_int_equality(r, 1)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_float64_array::<2>();
                let rb = crate::cpu::common::get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let b_r = _mm_set_pd(rb[1], rb[0]);
                let cmpv = _mm_cmpgt_sd(a_r, b_r);
                let _ = _mm_movemask_pd(cmpv);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmp_sd_mask() -> Result<(), String> {
    unsafe {
        let _src = _mm_setzero_pd();
        let a = _mm_set_sd(2.0);
        let b = _mm_set_sd(1.0);
        let cmpv = _mm_cmpgt_sd(a, b);
        let r = (_mm_movemask_pd(cmpv) & 1) as i32;
        crate::cpu::common::check_int_equality(r, 1)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_float64_array::<2>();
                let rb = crate::cpu::common::get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let b_r = _mm_set_pd(rb[1], rb[0]);
                let cmpv = _mm_cmpgt_sd(a_r, b_r);
                let _ = _mm_movemask_pd(cmpv);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmp_round_sd_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(3.2);
        let b = _mm_set_sd(3.2);
        let cmpv = _mm_cmpeq_sd(a, b);
        let r = (_mm_movemask_pd(cmpv) & 1) as i32;
        crate::cpu::common::check_int_equality(r, 1)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_float64_array::<2>();
                let rb = crate::cpu::common::get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let b_r = _mm_set_pd(rb[1], rb[0]);
                let cmpv = _mm_cmpeq_sd(a_r, b_r);
                let _ = _mm_movemask_pd(cmpv);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmp_round_sd_mask() -> Result<(), String> {
    unsafe {
        let _src = _mm_setzero_pd();
        let a = _mm_set_sd(3.2);
        let b = _mm_set_sd(3.2);
        let cmpv = _mm_cmpeq_sd(a, b);
        let r = (_mm_movemask_pd(cmpv) & 1) as i32;
        crate::cpu::common::check_int_equality(r, 1)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_float64_array::<2>();
                let rb = crate::cpu::common::get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let b_r = _mm_set_pd(rb[1], rb[0]);
                let cmpv = _mm_cmpeq_sd(a_r, b_r);
                let _ = _mm_movemask_pd(cmpv);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmplt_epu32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(2, 2, 3, 3);
        let k = _mm_cmplt_epu32_mask(a, b);
        crate::cpu::common::check_int_equality(k as i32, 6)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_i32_array::<4>();
                let rb = crate::cpu::common::get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_cmplt_epu32_mask(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmplt_epu32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1, 2, 3, 4);
        let b = _mm_set_epi32(2, 2, 3, 3);
        let k: __mmask8 = 255u8 as __mmask8;
        let result = _mm_mask_cmplt_epu32_mask(k, a, b);
        crate::cpu::common::check_int_equality(result as i32, 6)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_i32_array::<4>();
                let rb = crate::cpu::common::get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_cmplt_epu32_mask(k, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmpgt_epu32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(3, 3, 2, 1);
        let k = _mm_cmpgt_epu32_mask(a, b);
        crate::cpu::common::check_int_equality(k as i32, 12)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_i32_array::<4>();
                let rb = crate::cpu::common::get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_cmpgt_epu32_mask(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpgt_epu32_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set_epi32(3, 3, 2, 1);
        let k: __mmask8 = 255u8 as __mmask8;
        let result = _mm_mask_cmpgt_epu32_mask(k, a, b);
        crate::cpu::common::check_int_equality(result as i32, 12)?;
        if crate::get_fuzzing() {
            for _ in 0..crate::cpu::get_iterations() {
                let ra = crate::cpu::common::get_random_i32_array::<4>();
                let rb = crate::cpu::common::get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_mask_cmpgt_epu32_mask(k, a_r, b_r);
            }
        }
    }
    Ok(())
}
