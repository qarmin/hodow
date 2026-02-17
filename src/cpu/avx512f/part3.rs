use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_int_equality, get_random_float32_array, get_random_float64_array, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_cvt_roundu64_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(4.5);
        let r = _mm_cvt_roundss_u64::<0>(a);
        check_int_equality(r, 4)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float32_array::<1>();
                let _ = _mm_cvt_roundss_u64::<0>(_mm_set_ss(vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsd_si64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(4.5);
        let r = _mm_cvt_roundsd_si64::<0>(a);
        check_int_equality(r, 4)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<1>();
                let _ = _mm_cvt_roundsd_si64::<0>(_mm_set_sd(vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsd_i64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(4.5);
        let r = _mm_cvt_roundsd_i64::<0>(a);
        check_int_equality(r, 4)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<1>();
                let _ = _mm_cvt_roundsd_i64::<0>(_mm_set_sd(vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsd_u64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(4.5);
        let r = _mm_cvt_roundsd_u64::<0>(a);
        check_int_equality(r, 4)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<1>();
                let _ = _mm_cvt_roundsd_u64::<0>(_mm_set_sd(vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundss_si64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(4.5);
        let r = _mm_cvt_roundss_si64::<0>(a);
        check_int_equality(r, 4)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float32_array::<1>();
                let _ = _mm_cvt_roundss_si64::<0>(_mm_set_ss(vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundss_i64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(4.5);
        let r = _mm_cvt_roundss_i64::<0>(a);
        check_int_equality(r, 4)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float32_array::<1>();
                let _ = _mm_cvt_roundss_i64::<0>(_mm_set_ss(vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundss_u64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(4.5);
        let r = _mm_cvt_roundss_u64::<0>(a);
        check_int_equality(r, 4)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float32_array::<1>();
                let _ = _mm_cvt_roundss_u64::<0>(_mm_set_ss(vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundsd_si64() -> Result<(), String> {
    unsafe {
        let _a = _mm_set_sd(0.0); // input irrelevant for trunc variant check below
                                  // use explicit value to test truncation
        let a = _mm_set_pd(0.0, 3.9);
        let r = _mm_cvtt_roundsd_si64::<0>(a);
        check_int_equality(r, 3)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<1>();
                let _ = _mm_cvtt_roundsd_si64::<0>(_mm_set_pd(0.0, vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundsd_i64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(0.0, 3.9);
        let r = _mm_cvtt_roundsd_i64::<12>(a);
        check_int_equality(r, 3)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<1>();
                let _ = _mm_cvtt_roundsd_i64::<12>(_mm_set_pd(0.0, vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundsd_u64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(0.0, 3.9);
        let r = _mm_cvtt_roundsd_u64::<0>(a);
        check_int_equality(r, 3)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<1>();
                let _ = _mm_cvtt_roundsd_u64::<0>(_mm_set_pd(0.0, vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundss_i64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(3.9);
        let r = _mm_cvtt_roundss_i64::<0>(a);
        check_int_equality(r, 3)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float32_array::<1>();
                let _ = _mm_cvtt_roundss_i64::<0>(_mm_set_ss(vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundss_si64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(3.9);
        let r = _mm_cvtt_roundss_si64::<0>(a);
        check_int_equality(r, 3)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float32_array::<1>();
                let _ = _mm_cvtt_roundss_si64::<0>(_mm_set_ss(vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundss_u64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(3.9);
        let r = _mm_cvtt_roundss_u64::<0>(a);
        check_int_equality(r, 3)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float32_array::<1>();
                let _ = _mm_cvtt_roundss_u64::<0>(_mm_set_ss(vals[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_abs_epi32() -> Result<(), String> {
    unsafe {
        let src: __m128i = _mm_setzero_si128();
        let a = _mm_set_epi32(-4, -3, -2, -1);
        let k: __mmask8 = 111 as __mmask8;
        let result_v = _mm_mask_abs_epi32(src, k, a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result_v);
        check_array_equality(&result, &[1, 2, 3, 4])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(r[3], r[2], r[1], r[0]);
                let _ = _mm_mask_abs_epi32(src, k, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_abs_epi32() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 111 as __mmask8;
        let a = _mm_set_epi32(-4, -3, -2, -1);
        let result_v = _mm_maskz_abs_epi32(k, a);
        let result = std::mem::transmute::<__m128i, [i32; 4]>(result_v);
        check_array_equality(&result, &[1, 2, 3, 4])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(r[3], r[2], r[1], r[0]);
                let _ = _mm_maskz_abs_epi32(k, a_r);
            }
        }
    }
    Ok(())
}
