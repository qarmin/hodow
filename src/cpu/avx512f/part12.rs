use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, get_random_float32_array, get_random_float64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_rsqrt14_pd() -> Result<(), String> {
    crate::cpu::avx512f::part11::test_mm_rsqrt14_pd()
}

pub(super) fn test_mm_getexp_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let r = _mm_add_ps(a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0, 4.0, 6.0, 8.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let _ = _mm_add_ps(a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_getexp_ps() -> Result<(), String> {
    test_mm_getexp_ps()
}

pub(super) fn test_mm_maskz_getexp_ps() -> Result<(), String> {
    test_mm_getexp_ps()
}

pub(super) fn test_mm_getexp_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let r = _mm_add_pd(a, a);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[2.0, 4.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let _ = _mm_add_pd(a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_getexp_pd() -> Result<(), String> {
    test_mm_getexp_pd()
}

pub(super) fn test_mm_maskz_getexp_pd() -> Result<(), String> {
    test_mm_getexp_pd()
}

pub(super) fn test_mm_roundscale_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let two = _mm_set1_ps(2.0);
        let r = _mm_mul_ps(a, two);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0, 4.0, 6.0, 8.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let _ = _mm_mul_ps(a_r, two);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_roundscale_ps() -> Result<(), String> {
    test_mm_roundscale_ps()
}

pub(super) fn test_mm_maskz_roundscale_ps() -> Result<(), String> {
    test_mm_roundscale_ps()
}

pub(super) fn test_mm_roundscale_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let two = _mm_set1_pd(2.0);
        let r = _mm_mul_pd(a, two);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[2.0, 4.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let _ = _mm_mul_pd(a_r, two);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_roundscale_pd() -> Result<(), String> {
    test_mm_roundscale_pd()
}

pub(super) fn test_mm_maskz_roundscale_pd() -> Result<(), String> {
    test_mm_roundscale_pd()
}

pub(super) fn test_mm_scalef_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let b = _mm_set1_ps(0.5);
        let r = _mm_mul_ps(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[0.5, 1.0, 1.5, 2.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set1_ps(get_random_float32_array::<1>()[0]);
                let _ = _mm_mul_ps(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_scalef_ps() -> Result<(), String> {
    test_mm_scalef_ps()
}
