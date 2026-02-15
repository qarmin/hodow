use std::arch::x86_64::*;

use log::info;

use crate::cpu::get_iterations;
use crate::get_fuzzing;

use crate::cpu::common::{get_random_float32_array};

pub(super) fn test_mm_mask_scalef_round_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(2.25);
        let b = _mm_set1_ps(1.0);
        let _r = _mm_scalef_round_sh(a,b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_scalef_round_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0), _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC); } } }
    Ok(())
}

pub(super) fn test_mm_maskz_scalef_round_sh() -> Result<(), String> { test_mm_mask_scalef_round_sh() }

pub(super) fn test_mm_reduce_ph() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(1.0,2.0,3.0,4.0);
        let _r = _mm_reduce_ph(v, 0);
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_reduce_ph(_mm_set1_ps(get_random_float32_array::<1>()[0]), 0); } } }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_ph() -> Result<(), String> { test_mm_reduce_ph() }

pub(super) fn test_mm_maskz_reduce_ph() -> Result<(), String> { test_mm_reduce_ph() }

pub(super) fn test_mm_reduce_sh() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_ps(2.0);
        let _r = _mm_reduce_sh(v, 0);
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_reduce_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]), 0); } } }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_sh() -> Result<(), String> { test_mm_reduce_sh() }

pub(super) fn test_mm_maskz_reduce_sh() -> Result<(), String> { test_mm_reduce_sh() }

pub(super) fn test_mm_reduce_round_sh() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_ps(3.0);
        let _r = _mm_reduce_round_sh(v, 0, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_reduce_round_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]), 0, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC); } } }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_round_sh() -> Result<(), String> { test_mm_reduce_round_sh() }

pub(super) fn test_mm_maskz_reduce_round_sh() -> Result<(), String> { test_mm_reduce_round_sh() }

pub(super) fn test_mm_reduce_add_ph() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(1.0,2.0,3.0,4.0);
        let _r = _mm_reduce_add_ph(v);
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_reduce_add_ph(_mm_set1_ps(get_random_float32_array::<1>()[0])); } } }
    Ok(())
}

pub(super) fn test_mm_reduce_mul_ph() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(1.0,2.0,3.0,4.0);
        let _r = _mm_reduce_mul_ph(v);
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_reduce_mul_ph(_mm_set1_ps(get_random_float32_array::<1>()[0])); } } }
    Ok(())
}

pub(super) fn test_mm_reduce_min_ph() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(1.0,2.0,3.0,4.0);
        let _r = _mm_reduce_min_ph(v);
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_reduce_min_ph(_mm_set1_ps(get_random_float32_array::<1>()[0])); } } }
    Ok(())
}

pub(super) fn test_mm_reduce_max_ph() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(1.0,2.0,3.0,4.0);
        let _r = _mm_reduce_max_ph(v);
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_reduce_max_ph(_mm_set1_ps(get_random_float32_array::<1>()[0])); } } }
    Ok(())
}
