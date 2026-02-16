use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality_with_error, get_random_float32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_fcmul_pch() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(2.0, 2.0, 2.0, 2.0);
        let r = _mm_fcmul_pch(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality_with_error(&out, &[2.0, 4.0, 6.0, 8.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_fcmul_pch(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(2.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fcmul_pch() -> Result<(), String> {
    test_mm_mask_fcmul_pch()
}

pub(super) fn test_mm_fcmul_sch() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(1.0, 0.0, 1.0, 0.0);
        let r = _mm_fcmul_sch(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality_with_error(&out, &[1.0, 0.0, 3.0, 0.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_fcmul_sch(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fcmul_sch() -> Result<(), String> {
    test_mm_fcmul_sch()
}

pub(super) fn test_mm_maskz_fcmul_sch() -> Result<(), String> {
    test_mm_fcmul_sch()
}

pub(super) fn test_mm_fcmul_round_sch() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let r = _mm_fcmul_round_sch(a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality_with_error(&out, &[1.0, 2.0, 3.0, 4.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_fcmul_round_sch(
                    _mm_set1_ps(get_random_float32_array::<1>()[0]),
                    _mm_set1_ps(1.0),
                    _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC,
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fcmul_round_sch() -> Result<(), String> {
    test_mm_fcmul_round_sch()
}

pub(super) fn test_mm_maskz_fcmul_round_sch() -> Result<(), String> {
    test_mm_fcmul_round_sch()
}

pub(super) fn test_mm_abs_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(-1.0, -2.0, 3.0, -4.0);
        let r = _mm_abs_ph(a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality_with_error(&out, &[1.0, 2.0, 3.0, 4.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_abs_ph(_mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_conj_pch() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let r = _mm_conj_pch(a);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_conj_pch(_mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_conj_pch() -> Result<(), String> {
    test_mm_conj_pch()
}

pub(super) fn test_mm_maskz_conj_pch() -> Result<(), String> {
    test_mm_conj_pch()
}

pub(super) fn test_mm_fmadd_pch() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let c = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let r = _mm_fmadd_pch(a, b, c);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality_with_error(&out, &[2.0, 3.0, 4.0, 5.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_fmadd_pch(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fmadd_pch() -> Result<(), String> {
    test_mm_fmadd_pch()
}

pub(super) fn test_mm_mask3_fmadd_pch() -> Result<(), String> {
    test_mm_fmadd_pch()
}
