use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality, get_random_float32_array, get_random_float64_array, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_cvtepu64_ps() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi64x(1, 2);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(v);
        check_array_equality(&out, &[1, 2])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi64x(r[0] as i64, r[1] as i64);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtpd_epi64() -> Result<(), String> {
    unsafe {
        let v = _mm_set_pd(2.0, 1.0);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(v);
        check_float_array_equality(&out, &[1.0, 2.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtpd_epi64() -> Result<(), String> {
    test_mm_cvtpd_epi64()
}

pub(super) fn test_mm_maskz_cvtpd_epi64() -> Result<(), String> {
    test_mm_cvtpd_epi64()
}

pub(super) fn test_mm_cvtps_epi64() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_float_array_equality(&out, &[4.0, 3.0, 2.0, 1.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ps(
                    get_random_float32_array::<4>()[0],
                    get_random_float32_array::<4>()[1],
                    get_random_float32_array::<4>()[2],
                    get_random_float32_array::<4>()[3],
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtps_epi64() -> Result<(), String> {
    test_mm_cvtps_epi64()
}

pub(super) fn test_mm_maskz_cvtps_epi64() -> Result<(), String> {
    test_mm_cvtps_epi64()
}

pub(super) fn test_mm_cvtpd_epu64() -> Result<(), String> {
    unsafe {
        let v = _mm_set_pd(6.0, 5.0);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(v);
        check_float_array_equality(&out, &[5.0, 6.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtpd_epu64() -> Result<(), String> {
    test_mm_cvtpd_epu64()
}

pub(super) fn test_mm_maskz_cvtpd_epu64() -> Result<(), String> {
    test_mm_cvtpd_epu64()
}

pub(super) fn test_mm_cvtps_epu64() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(8.0, 7.0, 6.0, 5.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_float_array_equality(&out, &[8.0, 7.0, 6.0, 5.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ps(
                    get_random_float32_array::<4>()[0],
                    get_random_float32_array::<4>()[1],
                    get_random_float32_array::<4>()[2],
                    get_random_float32_array::<4>()[3],
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtps_epu64() -> Result<(), String> {
    test_mm_cvtps_epu64()
}

pub(super) fn test_mm_maskz_cvtps_epu64() -> Result<(), String> {
    test_mm_cvtps_epu64()
}

pub(super) fn test_mm_cvttpd_epi64() -> Result<(), String> {
    unsafe {
        let x = _mm_set_pd(3.0, 4.0);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(x);
        check_float_array_equality(&out, &[4.0, 3.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvttpd_epi64() -> Result<(), String> {
    test_mm_cvttpd_epi64()
}
