use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, get_random_float32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_mul_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(2.0, 2.0, 2.0, 2.0);
        let r = _mm_mul_ph(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0, 4.0, 6.0, 8.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_mul_ph(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(2.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mul_ph() -> Result<(), String> {
    test_mm_mask_mul_ph()
}

pub(super) fn test_mm_mul_round_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let r = _mm_mul_round_sh(a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[1.0, 2.0, 3.0, 4.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_mul_round_sh(
                    _mm_set1_ps(get_random_float32_array::<1>()[0]),
                    _mm_set1_ps(1.0),
                    _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC,
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_mul_round_sh() -> Result<(), String> {
    test_mm_mul_round_sh()
}

pub(super) fn test_mm_maskz_mul_round_sh() -> Result<(), String> {
    test_mm_mul_round_sh()
}

pub(super) fn test_mm_mul_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(2.0, 2.0, 2.0, 2.0);
        let b = _mm_set_ps(3.0, 3.0, 3.0, 3.0);
        let r = _mm_mul_sh(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[6.0, 6.0, 6.0, 6.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_mul_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_mul_sh() -> Result<(), String> {
    test_mm_mul_sh()
}

pub(super) fn test_mm_maskz_mul_sh() -> Result<(), String> {
    test_mm_mul_sh()
}

pub(super) fn test_mm_div_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(8.0, 6.0, 4.0, 2.0);
        let b = _mm_set_ps(2.0, 2.0, 2.0, 2.0);
        let r = _mm_div_ph(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[4.0, 3.0, 2.0, 1.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_div_ph(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_div_ph() -> Result<(), String> {
    test_mm_div_ph()
}

pub(super) fn test_mm_maskz_div_ph() -> Result<(), String> {
    test_mm_div_ph()
}

pub(super) fn test_mm_div_round_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(8.0, 6.0, 4.0, 2.0);
        let b = _mm_set_ps(2.0, 2.0, 2.0, 2.0);
        let r = _mm_div_round_sh(a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[4.0, 3.0, 2.0, 1.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_div_round_sh(
                    _mm_set1_ps(get_random_float32_array::<1>()[0]),
                    _mm_set1_ps(1.0),
                    _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC,
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_div_round_sh() -> Result<(), String> {
    test_mm_div_round_sh()
}

pub(super) fn test_mm_maskz_div_round_sh() -> Result<(), String> {
    test_mm_div_round_sh()
}

pub(super) fn test_mm_div_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(8.0, 6.0, 4.0, 2.0);
        let b = _mm_set_ps(2.0, 2.0, 2.0, 2.0);
        let r = _mm_div_sh(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[4.0, 3.0, 2.0, 1.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_div_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}
