use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_float64_array, get_random_i32_array, check_int_equality};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_cvttpd_epi64() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_pd(3.0);
        let r = _mm_cvttpd_epi64(v);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[3, 3])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvttpd_epi64(_mm_set1_pd(get_random_float64_array::<2>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttps_epi64() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_ps(4.0);
        let r = _mm_cvttps_epi64(v);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[4, 4])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvttps_epi64(_mm_set1_ps(get_random_float64_array::<2>()[0] as f32));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvttps_epi64() -> Result<(), String> {
    test_mm_cvttps_epi64()
}

pub(super) fn test_mm_maskz_cvttps_epi64() -> Result<(), String> {
    test_mm_cvttps_epi64()
}

pub(super) fn test_mm_cvttpd_epu64() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_pd(5.0);
        let r = _mm_cvttpd_epu64(v);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[5, 5])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvttpd_epu64(_mm_set1_pd(get_random_float64_array::<2>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvttpd_epu64() -> Result<(), String> {
    test_mm_cvttpd_epu64()
}

pub(super) fn test_mm_maskz_cvttpd_epu64() -> Result<(), String> {
    test_mm_cvttpd_epu64()
}

pub(super) fn test_mm_cvttps_epu64() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_ps(6.0);
        let r = _mm_cvttps_epu64(v);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[6, 6])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvttps_epu64(_mm_set1_ps(get_random_float64_array::<2>()[0] as f32));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvttps_epu64() -> Result<(), String> {
    test_mm_cvttps_epu64()
}

pub(super) fn test_mm_maskz_cvttps_epu64() -> Result<(), String> {
    test_mm_cvttps_epu64()
}

pub(super) fn test_mm_mullo_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(2);
        let b = _mm_set1_epi64x(3);
        let r = _mm_mullo_epi64(a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[6, 6])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_mullo_epi64(
                    _mm_set1_epi64x(get_random_i32_array::<4>()[0] as i64),
                    _mm_set1_epi64x(get_random_i32_array::<4>()[1] as i64),
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_mullo_epi64() -> Result<(), String> {
    test_mm_mullo_epi64()
}

pub(super) fn test_mm_maskz_mullo_epi64() -> Result<(), String> {
    test_mm_mullo_epi64()
}

pub(super) fn test_mm_movepi32_mask() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(1, 1, 1, 1);
        let m = _mm_movepi32_mask(v);
        check_int_equality(m as i32, 15)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_movepi32_mask(_mm_set1_epi32(get_random_i32_array::<4>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_movepi64_mask() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi64x(1, 1);
        let m = _mm_movepi64_mask(v);
        check_int_equality(m as i32, 3)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_movepi64_mask(_mm_set1_epi64x(get_random_i32_array::<4>()[0] as i64));
            }
        }
    }
    Ok(())
}
