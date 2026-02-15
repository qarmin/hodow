use std::arch::x86_64::*;

use log::info;

use crate::cpu::get_iterations;
use crate::get_fuzzing;

use crate::cpu::common::{check_array_equality, get_random_i32_array};

pub(super) fn test_mm_mask_sra_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(-8, -4, -2, -1, 16, 32, 64, 128);
        let r = _mm_sra_epi16(a, _mm_set1_epi16(1));
        let out: [i16;8] = std::mem::transmute::<__m128i, [i16;8]>(r);
        check_array_equality(&out, &[-4i16, -2, -1, -1, 8, 16, 32, 64])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_sra_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1)); } } }
    Ok(())
}

pub(super) fn test_mm_maskz_sra_epi16() -> Result<(), String> { test_mm_mask_sra_epi16() }

pub(super) fn test_mm_mask_srai_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(-16, -8, -4, -2, 1,2,3,4);
        let r = _mm_srai_epi16(a, 1);
        let out: [i16;8] = std::mem::transmute::<__m128i, [i16;8]>(r);
        check_array_equality(&out, &[-8i16, -4, -2, -1, 0,1,1,2])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_srai_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), 1); } } }
    Ok(())
}

pub(super) fn test_mm_maskz_srai_epi16() -> Result<(), String> { test_mm_mask_srai_epi16() }

pub(super) fn test_mm_srav_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(16,8,4,2,1,0,-1,-2);
        let b = _mm_set_epi16(1,1,1,1,1,1,1,1);
        let r = _mm_srav_epi16(a,b);
        let out: [i16;8] = std::mem::transmute::<__m128i, [i16;8]>(r);
        check_array_equality(&out, &[8i16,4,2,1,0,0, -1, -1])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_srav_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1)); } } }
    Ok(())
}

pub(super) fn test_mm_mask_srav_epi16() -> Result<(), String> { test_mm_srav_epi16() }

pub(super) fn test_mm_maskz_srav_epi16() -> Result<(), String> { test_mm_srav_epi16() }

pub(super) fn test_mm_permutex2var_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1,2,3,4,5,6,7,8);
        let idx = _mm_set_epi16(0,1,2,3,4,5,6,7);
        let r = _mm_permutex2var_epi16(a, idx, a);
        let _out: [i16;8] = std::mem::transmute::<__m128i, [i16;8]>(r);
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_permutex2var_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(0), _mm_set1_epi16(1)); } } }
    Ok(())
}

pub(super) fn test_mm_mask_permutex2var_epi16() -> Result<(), String> { test_mm_permutex2var_epi16() }

pub(super) fn test_mm_maskz_permutex2var_epi16() -> Result<(), String> { test_mm_permutex2var_epi16() }

pub(super) fn test_mm_mask2_permutex2var_epi16() -> Result<(), String> { test_mm_permutex2var_epi16() }

pub(super) fn test_mm_permutexvar_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(7,6,5,4,3,2,1,0);
        let idx = _mm_set_epi16(0,1,2,3,4,5,6,7);
        let r = _mm_permutexvar_epi16(idx, a);
        let _out: [i16;8] = std::mem::transmute::<__m128i, [i16;8]>(r);
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_permutexvar_epi16(_mm_set1_epi16(0), _mm_set1_epi16(get_random_i32_array::<4>()[0] as i16)); } } }
    Ok(())
}

pub(super) fn test_mm_mask_permutexvar_epi16() -> Result<(), String> { test_mm_permutexvar_epi16() }

pub(super) fn test_mm_maskz_permutexvar_epi16() -> Result<(), String> { test_mm_permutexvar_epi16() }

pub(super) fn test_mm_mask_blend_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1,2,3,4,5,6,7,8);
        let b = _mm_set_epi16(8,7,6,5,4,3,2,1);
        let r = _mm_mask_blend_epi16(0b10101010u32, a, b);
        let _out: [i16;8] = std::mem::transmute::<__m128i, [i16;8]>(r);
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_mask_blend_epi16(0b10101010u32, _mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1)); } } }
    Ok(())
}
