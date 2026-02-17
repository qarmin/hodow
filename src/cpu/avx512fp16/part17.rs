use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, get_random_float32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_max_round_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 3.0, 2.0, 4.0);
        let b = _mm_set_ps(2.0, 2.0, 2.0, 2.0);
        let r = _mm_max_round_sh(a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_max_round_sh(
                    _mm_set1_ps(get_random_float32_array::<1>()[0]),
                    _mm_set1_ps(1.0),
                    _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC,
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_max_round_sh() -> Result<(), String> {
    test_mm_mask_max_round_sh()
}

pub(super) fn test_mm_min_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 5.0, 3.0, 4.0);
        let b = _mm_set_ps(2.0, 2.0, 6.0, 1.0);
        let r = _mm_min_ph(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[1.0, 2.0, 3.0, 1.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_min_ph(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_min_ph() -> Result<(), String> {
    test_mm_min_ph()
}

pub(super) fn test_mm_maskz_min_ph() -> Result<(), String> {
    test_mm_min_ph()
}

pub(super) fn test_mm_min_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(3.0);
        let b = _mm_set1_ps(2.0);
        let r = _mm_min_sh(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0, 2.0, 2.0, 2.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_min_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_min_sh() -> Result<(), String> {
    test_mm_min_sh()
}

pub(super) fn test_mm_maskz_min_sh() -> Result<(), String> {
    test_mm_min_sh()
}

pub(super) fn test_mm_min_round_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(2.5);
        let b = _mm_set1_ps(2.4);
        let r = _mm_min_round_sh(a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_min_round_sh(
                    _mm_set1_ps(get_random_float32_array::<1>()[0]),
                    _mm_set1_ps(1.0),
                    _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC,
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_min_round_sh() -> Result<(), String> {
    test_mm_min_round_sh()
}

pub(super) fn test_mm_maskz_min_round_sh() -> Result<(), String> {
    test_mm_min_round_sh()
}

pub(super) fn test_mm_getexp_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 4.0, 8.0);
        let r = _mm_getexp_ph(a);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_getexp_ph(_mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_getexp_ph() -> Result<(), String> {
    test_mm_getexp_ph()
}

pub(super) fn test_mm_maskz_getexp_ph() -> Result<(), String> {
    test_mm_getexp_ph()
}

pub(super) fn test_mm_getexp_sh() -> Result<(), String> {
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
