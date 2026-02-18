use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, get_random_float32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_roundscale_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(2.5);
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

pub(super) fn test_mm_maskz_roundscale_ph() -> Result<(), String> {
    test_mm_mask_roundscale_ph()
}

pub(super) fn test_mm_roundscale_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(3.75);
        let r = _mm_roundscale_sh(a, 1);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_roundscale_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]), 1);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_roundscale_sh() -> Result<(), String> {
    test_mm_roundscale_sh()
}

pub(super) fn test_mm_maskz_roundscale_sh() -> Result<(), String> {
    test_mm_roundscale_sh()
}

pub(super) fn test_mm_roundscale_round_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(4.5);
        let r = _mm_roundscale_round_sh(a, 1);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_roundscale_round_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]), 1);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_roundscale_round_sh() -> Result<(), String> {
    test_mm_roundscale_round_sh()
}

pub(super) fn test_mm_maskz_roundscale_round_sh() -> Result<(), String> {
    test_mm_roundscale_round_sh()
}

pub(super) fn test_mm_scalef_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(2.0);
        let b = _mm_set1_ps(3.0);
        let r = _mm_scalef_ph(a, b);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_scalef_ph(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_scalef_ph() -> Result<(), String> {
    test_mm_scalef_ph()
}

pub(super) fn test_mm_maskz_scalef_ph() -> Result<(), String> {
    test_mm_scalef_ph()
}

pub(super) fn test_mm_scalef_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.5);
        let b = _mm_set1_ps(2.0);
        let r = _mm_scalef_sh(a, b);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_scalef_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_scalef_sh() -> Result<(), String> {
    test_mm_scalef_sh()
}

pub(super) fn test_mm_maskz_scalef_sh() -> Result<(), String> {
    test_mm_scalef_sh()
}

pub(super) fn test_mm_scalef_round_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(2.25);
        let b = _mm_set1_ps(1.0);
        let r = _mm_scalef_round_sh(a, b);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_scalef_round_sh(
                    _mm_set1_ps(get_random_float32_array::<1>()[0]),
                    _mm_set1_ps(1.0),
                    _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC,
                );
            }
        }
    }
    Ok(())
}
