use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality_with_error, get_random_float32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_getexp_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(8.0);
        let r = _mm_getexp_sh(a);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_getexp_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_getexp_sh() -> Result<(), String> {
    test_mm_mask_getexp_sh()
}

pub(super) fn test_mm_getexp_round_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(4.0);
        let r = _mm_getexp_round_sh(a, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_getexp_round_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]), _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_getexp_round_sh() -> Result<(), String> {
    test_mm_getexp_round_sh()
}

pub(super) fn test_mm_maskz_getexp_round_sh() -> Result<(), String> {
    test_mm_getexp_round_sh()
}

pub(super) fn test_mm_getmant_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(3.5);
        let r = _mm_getmant_ph(a);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_getmant_ph(_mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_getmant_ph() -> Result<(), String> {
    test_mm_getmant_ph()
}

pub(super) fn test_mm_maskz_getmant_ph() -> Result<(), String> {
    test_mm_getmant_ph()
}

pub(super) fn test_mm_getmant_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(6.5);
        let r = _mm_getmant_sh(a);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_getmant_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_getmant_sh() -> Result<(), String> {
    test_mm_getmant_sh()
}

pub(super) fn test_mm_maskz_getmant_sh() -> Result<(), String> {
    test_mm_getmant_sh()
}

pub(super) fn test_mm_getmant_round_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(7.5);
        let r = _mm_getmant_round_sh(a, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_getmant_round_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]), _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_getmant_round_sh() -> Result<(), String> {
    test_mm_getmant_round_sh()
}

pub(super) fn test_mm_maskz_getmant_round_sh() -> Result<(), String> {
    test_mm_getmant_round_sh()
}

pub(super) fn test_mm_roundscale_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.25);
        let r = _mm_roundscale_ph(a, 1);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_roundscale_ph(_mm_set1_ps(get_random_float32_array::<1>()[0]), 1);
            }
        }
    }
    Ok(())
}
