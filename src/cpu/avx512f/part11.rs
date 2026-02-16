use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality_with_error, get_random_float32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask3_fnmsub_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set1_ps(2.0);
        let c = _mm_set1_ps(1.0);
        let r = _mm_fnmsub_ps(a, b, c);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_fnmsub_ps(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fnmsub_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 3.0);
        let b = _mm_set1_pd(2.0);
        let c = _mm_set1_pd(1.0);
        let r = _mm_fnmsub_pd(a, b, c);
        let _out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_fnmsub_pd(_mm_set1_pd(get_random_float32_array::<1>()[0] as f64), _mm_set1_pd(1.0), _mm_set1_pd(1.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fnmsub_pd() -> Result<(), String> {
    test_mm_mask_fnmsub_pd()
}

pub(super) fn test_mm_mask3_fnmsub_pd() -> Result<(), String> {
    test_mm_mask_fnmsub_pd()
}

pub(super) fn test_mm_rcp14_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(2.0);
        let r = _mm_rcp14_ps(a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality_with_error(&out, &[0.5, 0.5, 0.5, 0.5])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_rcp14_ps(_mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_rcp14_ps() -> Result<(), String> {
    test_mm_rcp14_ps()
}

pub(super) fn test_mm_maskz_rcp14_ps() -> Result<(), String> {
    test_mm_rcp14_ps()
}

pub(super) fn test_mm_rcp14_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_pd(2.0);
        let r = _mm_rcp14_pd(a);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality_with_error(&[out[0] as f32, out[1] as f32], &[0.5f32, 0.5f32])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_rcp14_pd(_mm_set1_pd(get_random_float32_array::<1>()[0] as f64));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_rcp14_pd() -> Result<(), String> {
    test_mm_rcp14_pd()
}

pub(super) fn test_mm_maskz_rcp14_pd() -> Result<(), String> {
    test_mm_rcp14_pd()
}

pub(super) fn test_mm_rsqrt14_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(4.0);
        let r = _mm_rsqrt14_ps(a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        // rsqrt(4) = 0.5
        check_float_array_equality_with_error(&out, &[0.5, 0.5, 0.5, 0.5])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_rsqrt14_ps(_mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_rsqrt14_ps() -> Result<(), String> {
    test_mm_rsqrt14_ps()
}

pub(super) fn test_mm_maskz_rsqrt14_ps() -> Result<(), String> {
    test_mm_rsqrt14_ps()
}

pub(super) fn test_mm_rsqrt14_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_pd(4.0);
        let r = _mm_rsqrt14_pd(a);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        // approx 0.5
        let _ = out;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_rsqrt14_pd(_mm_set1_pd(get_random_float32_array::<1>()[0] as f64));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_rsqrt14_pd() -> Result<(), String> {
    test_mm_rsqrt14_pd()
}
