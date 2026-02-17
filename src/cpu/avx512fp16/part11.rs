use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, get_random_float32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask3_fcmadd_sch() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(2.0, 2.0, 2.0, 2.0);
        let c = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let r = _mm_fcmadd_sch(a, b, c);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[3.0, 5.0, 7.0, 9.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_fcmadd_sch(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(2.0), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fcmadd_sch() -> Result<(), String> {
    test_mm_mask3_fcmadd_sch()
}

pub(super) fn test_mm_fcmadd_round_sch() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let c = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let r = _mm_fcmadd_round_sch(a, b, c, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0, 3.0, 4.0, 5.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_fcmadd_round_sch(
                    _mm_set1_ps(get_random_float32_array::<1>()[0]),
                    _mm_set1_ps(1.0),
                    _mm_set1_ps(1.0),
                    _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC,
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fcmadd_round_sch() -> Result<(), String> {
    test_mm_fcmadd_round_sch()
}

pub(super) fn test_mm_mask3_fcmadd_round_sch() -> Result<(), String> {
    test_mm_fcmadd_round_sch()
}

pub(super) fn test_mm_maskz_fcmadd_round_sch() -> Result<(), String> {
    test_mm_fcmadd_round_sch()
}

pub(super) fn test_mm_fmadd_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let c = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let r = _mm_fmadd_ph(a, b, c);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0, 3.0, 4.0, 5.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_fmadd_ph(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fmadd_ph() -> Result<(), String> {
    test_mm_fmadd_ph()
}

pub(super) fn test_mm_mask3_fmadd_ph() -> Result<(), String> {
    test_mm_fmadd_ph()
}

pub(super) fn test_mm_maskz_fmadd_ph() -> Result<(), String> {
    test_mm_fmadd_ph()
}

pub(super) fn test_mm_fmadd_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let b = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let c = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let r = _mm_fmadd_sh(a, b, c);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[5.0, 5.0, 5.0, 5.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_fmadd_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fmadd_sh() -> Result<(), String> {
    test_mm_fmadd_sh()
}

pub(super) fn test_mm_mask3_fmadd_sh() -> Result<(), String> {
    test_mm_fmadd_sh()
}

pub(super) fn test_mm_maskz_fmadd_sh() -> Result<(), String> {
    test_mm_fmadd_sh()
}

pub(super) fn test_mm_fmadd_round_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let c = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let r = _mm_fmadd_round_sh(a, b, c, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0, 3.0, 4.0, 5.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_fmadd_round_sh(
                    _mm_set1_ps(get_random_float32_array::<1>()[0]),
                    _mm_set1_ps(1.0),
                    _mm_set1_ps(1.0),
                    _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC,
                );
            }
        }
    }
    Ok(())
}
