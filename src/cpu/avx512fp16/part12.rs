use std::arch::x86_64::*;

use log::info;

use crate::cpu::get_iterations;
use crate::get_fuzzing;

use crate::cpu::common::{check_float_array_equality_with_error, get_random_float32_array};

pub(super) fn test_mm_mask_fmadd_round_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0,2.0,3.0,4.0);
        let b = _mm_set_ps(1.0,1.0,1.0,1.0);
        let c = _mm_set_ps(1.0,1.0,1.0,1.0);
        let r = _mm_fmadd_round_sh(a,b,c, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f32;4] = std::mem::transmute::<__m128, [f32;4]>(r);
        check_float_array_equality_with_error(&out, &[2.0,3.0,4.0,5.0])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_fmadd_round_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0), _mm_set1_ps(1.0), _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC); } } }
    Ok(())
}

pub(super) fn test_mm_mask3_fmadd_round_sh() -> Result<(), String> { test_mm_mask_fmadd_round_sh() }

pub(super) fn test_mm_maskz_fmadd_round_sh() -> Result<(), String> { test_mm_mask_fmadd_round_sh() }

pub(super) fn test_mm_fmsub_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(5.0,6.0,7.0,8.0);
        let b = _mm_set_ps(1.0,2.0,3.0,4.0);
        let c = _mm_set_ps(1.0,1.0,1.0,1.0);
        let r = _mm_fmsub_ph(a,b,c);
        let out: [f32;4] = std::mem::transmute::<__m128, [f32;4]>(r);
        check_float_array_equality_with_error(&out, &[4.0,11.0,20.0,31.0])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_fmsub_ph(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0), _mm_set1_ps(1.0)); } } }
    Ok(())
}

pub(super) fn test_mm_mask_fmsub_ph() -> Result<(), String> { test_mm_fmsub_ph() }

pub(super) fn test_mm_mask3_fmsub_ph() -> Result<(), String> { test_mm_fmsub_ph() }

pub(super) fn test_mm_maskz_fmsub_ph() -> Result<(), String> { test_mm_fmsub_ph() }

pub(super) fn test_mm_fmsub_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0,3.0,2.0,1.0);
        let b = _mm_set_ps(1.0,2.0,3.0,4.0);
        let c = _mm_set_ps(1.0,1.0,1.0,1.0);
        let r = _mm_fmsub_sh(a,b,c);
        let out: [f32;4] = std::mem::transmute::<__m128, [f32;4]>(r);
        check_float_array_equality_with_error(&out, &[3.0,5.0,5.0,3.0])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_fmsub_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0), _mm_set1_ps(1.0)); } } }
    Ok(())
}

pub(super) fn test_mm_mask_fmsub_sh() -> Result<(), String> { test_mm_fmsub_sh() }

pub(super) fn test_mm_mask3_fmsub_sh() -> Result<(), String> { test_mm_fmsub_sh() }

pub(super) fn test_mm_maskz_fmsub_sh() -> Result<(), String> { test_mm_fmsub_sh() }

pub(super) fn test_mm_fmsub_round_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(2.0,3.0,4.0,5.0);
        let b = _mm_set_ps(1.0,1.0,1.0,1.0);
        let c = _mm_set_ps(1.0,1.0,1.0,1.0);
        let r = _mm_fmsub_round_sh(a,b,c, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f32;4] = std::mem::transmute::<__m128, [f32;4]>(r);
        check_float_array_equality_with_error(&out, &[1.0,2.0,3.0,4.0])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_fmsub_round_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0), _mm_set1_ps(1.0), _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC); } } }
    Ok(())
}

pub(super) fn test_mm_mask_fmsub_round_sh() -> Result<(), String> { test_mm_fmsub_round_sh() }

pub(super) fn test_mm_mask3_fmsub_round_sh() -> Result<(), String> { test_mm_fmsub_round_sh() }

pub(super) fn test_mm_maskz_fmsub_round_sh() -> Result<(), String> { test_mm_fmsub_round_sh() }
