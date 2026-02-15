use std::arch::x86_64::*;

use log::info;

use crate::cpu::get_iterations;
use crate::get_fuzzing;

use crate::cpu::common::{check_array_equality, get_random_float32_array};

pub(super) fn test_mm_mask_cvt_roundsd_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_pd(2.0);
        let r = _mm_cvt_roundsd_sh(a, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let _out: [f64;2] = std::mem::transmute::<__m128d, [f64;2]>(r);
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_cvt_roundsd_sh(_mm_set1_pd(get_random_float32_array::<1>()[0] as f64), _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC); } } }
    Ok(())
}

pub(super) fn test_mm_maskz_cvt_roundsd_sh() -> Result<(), String> { test_mm_mask_cvt_roundsd_sh() }

pub(super) fn test_mm_cvtph_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0,2.0,3.0,4.0);
        let r = _mm_cvtph_epi16(a);
        let out: [i16;8] = std::mem::transmute::<__m128i, [i16;8]>(r);
        check_array_equality(&out, &[1i16,0,2,0,3,0,4,0])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_cvtph_epi16(_mm_set1_ps(get_random_float32_array::<1>()[0])); } } }
    Ok(())
}

pub(super) fn test_mm_mask_cvtph_epi16() -> Result<(), String> { test_mm_cvtph_epi16() }

pub(super) fn test_mm_maskz_cvtph_epi16() -> Result<(), String> { test_mm_cvtph_epi16() }

pub(super) fn test_mm_cvtph_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0,2.0,3.0,4.0);
        let r = _mm_cvtph_epu16(a);
        let out: [u16;8] = std::mem::transmute::<__m128i, [u16;8]>(r);
        check_array_equality(&out, &[1u16,0,2,0,3,0,4,0])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_cvtph_epu16(_mm_set1_ps(get_random_float32_array::<1>()[0])); } } }
    Ok(())
}

pub(super) fn test_mm_mask_cvtph_epu16() -> Result<(), String> { test_mm_cvtph_epu16() }

pub(super) fn test_mm_maskz_cvtph_epu16() -> Result<(), String> { test_mm_cvtph_epu16() }

pub(super) fn test_mm_cvttph_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0,2.0,3.0,4.0);
        let r = _mm_cvttph_epi16(a);
        let out: [i16;8] = std::mem::transmute::<__m128i, [i16;8]>(r);
        check_array_equality(&out, &[1i16,0,2,0,3,0,4,0])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_cvttph_epi16(_mm_set1_ps(get_random_float32_array::<1>()[0])); } } }
    Ok(())
}

pub(super) fn test_mm_mask_cvttph_epi16() -> Result<(), String> { test_mm_cvttph_epi16() }

pub(super) fn test_mm_maskz_cvttph_epi16() -> Result<(), String> { test_mm_cvttph_epi16() }

pub(super) fn test_mm_cvttph_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0,2.0,3.0,4.0);
        let r = _mm_cvttph_epu16(a);
        let out: [u16;8] = std::mem::transmute::<__m128i, [u16;8]>(r);
        check_array_equality(&out, &[1u16,0,2,0,3,0,4,0])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_cvttph_epu16(_mm_set1_ps(get_random_float32_array::<1>()[0])); } } }
    Ok(())
}

pub(super) fn test_mm_mask_cvttph_epu16() -> Result<(), String> { test_mm_cvttph_epu16() }

pub(super) fn test_mm_maskz_cvttph_epu16() -> Result<(), String> { test_mm_cvttph_epu16() }

pub(super) fn test_mm_cvtph_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0,2.0,3.0,4.0);
        let r = _mm_cvtph_epi32(a);
        let out: [i32;4] = std::mem::transmute::<__m128i, [i32;4]>(r);
        check_array_equality(&out, &[1i32,2,3,4])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_cvtph_epi32(_mm_set1_ps(get_random_float32_array::<1>()[0])); } } }
    Ok(())
}
