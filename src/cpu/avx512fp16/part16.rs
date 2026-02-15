use std::arch::x86_64::*;

use log::info;

use crate::cpu::get_iterations;
use crate::get_fuzzing;

use crate::cpu::common::{check_float_array_equality_with_error, get_random_float32_array};

pub(super) fn test_mm_mask_sqrt_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0,4.0,9.0,16.0);
        let r = _mm_sqrt_ph(a);
        let out: [f32;4] = std::mem::transmute::<__m128, [f32;4]>(r);
        check_float_array_equality_with_error(&out, &[1.0,2.0,3.0,4.0])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_sqrt_ph(_mm_set1_ps(get_random_float32_array::<1>()[0])); } } }
    Ok(())
}

pub(super) fn test_mm_maskz_sqrt_ph() -> Result<(), String> { test_mm_mask_sqrt_ph() }

pub(super) fn test_mm_sqrt_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(4.0);
        let r = _mm_sqrt_sh(a);
        let out: [f32;4] = std::mem::transmute::<__m128, [f32;4]>(r);
        // sqrt(4.0) == 2.0
        check_float_array_equality_with_error(&out, &[2.0,2.0,2.0,2.0])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_sqrt_sh(_mm_set1_ps(get_random_float32_array::<1>()[0])); } } }
    Ok(())
}

pub(super) fn test_mm_mask_sqrt_sh() -> Result<(), String> { test_mm_sqrt_sh() }

pub(super) fn test_mm_maskz_sqrt_sh() -> Result<(), String> { test_mm_sqrt_sh() }

pub(super) fn test_mm_sqrt_round_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(2.25);
        let r = _mm_sqrt_round_sh(a, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let _out: [f32;4] = std::mem::transmute::<__m128, [f32;4]>(r);
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_sqrt_round_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]), _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC); } } }
    Ok(())
}

pub(super) fn test_mm_mask_sqrt_round_sh() -> Result<(), String> { test_mm_sqrt_round_sh() }

pub(super) fn test_mm_maskz_sqrt_round_sh() -> Result<(), String> { test_mm_sqrt_round_sh() }

pub(super) fn test_mm_max_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0,5.0,3.0,4.0);
        let b = _mm_set_ps(2.0,2.0,6.0,1.0);
        let r = _mm_max_ph(a,b);
        let out: [f32;4] = std::mem::transmute::<__m128, [f32;4]>(r);
        check_float_array_equality_with_error(&out, &[2.0,5.0,6.0,4.0])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_max_ph(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0)); } } }
    Ok(())
}

pub(super) fn test_mm_mask_max_ph() -> Result<(), String> { test_mm_max_ph() }

pub(super) fn test_mm_maskz_max_ph() -> Result<(), String> { test_mm_max_ph() }

pub(super) fn test_mm_max_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(3.0);
        let b = _mm_set1_ps(2.0);
        let r = _mm_max_sh(a,b);
        let out: [f32;4] = std::mem::transmute::<__m128, [f32;4]>(r);
        check_float_array_equality_with_error(&out, &[3.0,3.0,3.0,3.0])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_max_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0)); } } }
    Ok(())
}

pub(super) fn test_mm_mask_max_sh() -> Result<(), String> { test_mm_max_sh() }

pub(super) fn test_mm_maskz_max_sh() -> Result<(), String> { test_mm_max_sh() }

pub(super) fn test_mm_max_round_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(2.5);
        let b = _mm_set1_ps(2.4);
        let r = _mm_max_round_sh(a,b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let _out: [f32;4] = std::mem::transmute::<__m128, [f32;4]>(r);
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_max_round_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0), _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC); } } }
    Ok(())
}
