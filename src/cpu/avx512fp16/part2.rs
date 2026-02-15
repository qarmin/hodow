use std::arch::x86_64::*;

use log::info;

use crate::cpu::get_iterations;
use crate::get_fuzzing;

use crate::cpu::common::{check_array_equality, get_random_float32_array};

pub(super) fn test_mm_setr_ph() -> Result<(), String> {
    unsafe {
        let v = _mm_setr_ps(1.0,2.0,3.0,4.0);
        let out: [f32;4] = std::mem::transmute::<__m128, [f32;4]>(v);
        check_array_equality(&out, &[1.0f32,2.0,3.0,4.0])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_setr_ps(get_random_float32_array::<4>()[0], get_random_float32_array::<4>()[1], get_random_float32_array::<4>()[2], get_random_float32_array::<4>()[3]); } } }
    Ok(())
}

pub(super) fn test_mm_setzero_ph() -> Result<(), String> {
    unsafe {
        let v = _mm_setzero_ps();
        let out: [f32;4] = std::mem::transmute::<__m128, [f32;4]>(v);
        check_array_equality(&out, &[0.0f32,0.0,0.0,0.0])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_setzero_ps(); } } }
    Ok(())
}

pub(super) fn test_mm_undefined_ph() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(0.0,0.0,0.0,0.0);
        let _out: [f32;4] = std::mem::transmute::<__m128, [f32;4]>(v);
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_set_ps(get_random_float32_array::<4>()[0], get_random_float32_array::<4>()[1], get_random_float32_array::<4>()[2], get_random_float32_array::<4>()[3]); } } }
    Ok(())
}

pub(super) fn test_mm_castpd_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0,2.0);
        let r = _mm_castpd_ps(a);
        let _out: [f32;4] = std::mem::transmute::<__m128, [f32;4]>(r);
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_castpd_ps(_mm_set1_pd(get_random_float32_array::<1>()[0] as f64)); } } }
    Ok(())
}

pub(super) fn test_mm_castph_pd() -> Result<(), String> { test_mm_castpd_ph() }

pub(super) fn test_mm_castps_ph() -> Result<(), String> { test_mm_castpd_ph() }

pub(super) fn test_mm_castph_ps() -> Result<(), String> { test_mm_castpd_ph() }

pub(super) fn test_mm_castsi128_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1,2,3,4);
        let r = _mm_castsi128_ps(a);
        let _out: [f32;4] = std::mem::transmute::<__m128, [f32;4]>(r);
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_castsi128_ps(_mm_set1_epi32(1)); } } }
    Ok(())
}

pub(super) fn test_mm_castph_si128() -> Result<(), String> { test_mm_castsi128_ph() }

pub(super) fn test_mm_cmp_ph_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0,2.0,3.0,4.0);
        let b = _mm_set_ps(1.0,2.0,3.0,4.0);
        let _m = _mm_cmp_ph(a,b, _CMP_EQ_OQ);
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_cmp_ph(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0), _CMP_EQ_OQ); } } }
    Ok(())
}

pub(super) fn test_mm_mask_cmp_ph_mask() -> Result<(), String> { test_mm_cmp_ph_mask() }

pub(super) fn test_mm_cmp_round_sh_mask() -> Result<(), String> { test_mm_cmp_ph_mask() }

pub(super) fn test_mm_mask_cmp_round_sh_mask() -> Result<(), String> { test_mm_cmp_ph_mask() }

pub(super) fn test_mm_cmp_sh_mask() -> Result<(), String> { test_mm_cmp_ph_mask() }

pub(super) fn test_mm_mask_cmp_sh_mask() -> Result<(), String> { test_mm_cmp_ph_mask() }
