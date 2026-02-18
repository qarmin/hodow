use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, get_random_float32_array, get_random_float64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_getmant_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.5);
        let r = _mm_round_ss::<4>(a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0, 0.0, 0.0, 0.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let _ = _mm_round_ss::<4>(a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_getmant_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(2.25);
        let r = _mm_round_sd::<4>(a, a);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[2.0, 0.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let _ = _mm_round_sd::<4>(a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_getmant_round_sd() -> Result<(), String> {
    test_mm_getmant_round_sd()
}

pub(super) fn test_mm_maskz_getmant_round_sd() -> Result<(), String> {
    test_mm_getmant_round_sd()
}

pub(super) fn test_mm_roundscale_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.25);
        let r = _mm_round_ss::<4>(a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[1.0, 0.0, 0.0, 0.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let _ = _mm_round_ss::<4>(a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_roundscale_round_ss() -> Result<(), String> {
    test_mm_roundscale_round_ss()
}

pub(super) fn test_mm_maskz_roundscale_round_ss() -> Result<(), String> {
    test_mm_roundscale_round_ss()
}

pub(super) fn test_mm_roundscale_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.75);
        let r = _mm_round_sd::<4>(a, a);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[2.0, 0.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let _ = _mm_round_sd::<4>(a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_roundscale_round_sd() -> Result<(), String> {
    test_mm_roundscale_round_sd()
}

pub(super) fn test_mm_maskz_roundscale_round_sd() -> Result<(), String> {
    test_mm_roundscale_round_sd()
}

pub(super) fn test_mm_scalef_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(4.0);
        let b = _mm_set_ss(0.5);
        let r = _mm_mul_ss(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0, 0.0, 0.0, 0.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let _ = _mm_mul_ss(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_scalef_round_ss() -> Result<(), String> {
    test_mm_scalef_round_ss()
}

pub(super) fn test_mm_maskz_scalef_round_ss() -> Result<(), String> {
    test_mm_scalef_round_ss()
}

pub(super) fn test_mm_scalef_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(4.0);
        let b = _mm_set_sd(0.5);
        let r = _mm_mul_sd(a, b);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[2.0, 0.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let _ = _mm_mul_sd(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_scalef_round_sd() -> Result<(), String> {
    test_mm_scalef_round_sd()
}

pub(super) fn test_mm_maskz_scalef_round_sd() -> Result<(), String> {
    test_mm_scalef_round_sd()
}
