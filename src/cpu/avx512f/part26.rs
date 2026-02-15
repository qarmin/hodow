use std::arch::x86_64::*;

use log::info;

use crate::cpu::get_iterations;
use crate::get_fuzzing;

use crate::cpu::common::{get_random_i32_array};

fn test_mm_maskz_sra_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(-8,-4,-2,-1);
        let sh = _mm_set1_epi32(1);
        let r = _mm_sra_epi32(a, sh);
        let _out: [i32;4] = std::mem::transmute::<__m128i, [i32;4]>(r);
    }
    if crate::get_fuzzing() { info!("Starting fuzzing"); for _ in 0..crate::cpu::get_iterations() { unsafe { let _ = _mm_sra_epi32(_mm_set1_epi32(get_random_i32_array::<4>()[0]), _mm_set1_epi32(1)); } } }
    Ok(())
}

fn test_mm_sra_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(-8, -4);
        let r = _mm_sra_epi64(a, _mm_set1_epi64x(1));
        let _out: [i64;2] = std::mem::transmute::<__m128i, [i64;2]>(r);
    }
    if crate::get_fuzzing() { info!("Starting fuzzing"); for _ in 0..crate::cpu::get_iterations() { unsafe { let _ = _mm_sra_epi64(_mm_set1_epi64x(get_random_i32_array::<4>()[0] as i64), _mm_set1_epi64x(1)); } } }
    Ok(())
}

fn test_mm_mask_sra_epi64() -> Result<(), String> { test_mm_sra_epi64() }

fn test_mm_maskz_sra_epi64() -> Result<(), String> { test_mm_sra_epi64() }

fn test_mm_mask_srai_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(-16,-8,-4,-2);
        let r = _mm_srai_epi32(a, 1);
        let _out: [i32;4] = std::mem::transmute::<__m128i, [i32;4]>(r);
    }
    if crate::get_fuzzing() { info!("Starting fuzzing"); for _ in 0..crate::cpu::get_iterations() { unsafe { let _ = _mm_srai_epi32(_mm_set1_epi32(get_random_i32_array::<4>()[0]), 1); } } }
    Ok(())
}

fn test_mm_maskz_srai_epi32() -> Result<(), String> { test_mm_mask_srai_epi32() }

fn test_mm_srai_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(-16, -8);
        let r = _mm_srai_epi64(a, 1);
        let _out: [i64;2] = std::mem::transmute::<__m128i, [i64;2]>(r);
    }
    if crate::get_fuzzing() { info!("Starting fuzzing"); for _ in 0..crate::cpu::get_iterations() { unsafe { let _ = _mm_srai_epi64(_mm_set1_epi64x(get_random_i32_array::<4>()[0] as i64), 1); } } }
    Ok(())
}

fn test_mm_mask_srai_epi64() -> Result<(), String> { test_mm_srai_epi64() }

fn test_mm_maskz_srai_epi64() -> Result<(), String> { test_mm_srai_epi64() }

fn test_mm_mask_srav_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(16,8,4,2);
        let b = _mm_set1_epi32(1);
        let r = _mm_srav_epi32(a,b);
        let _out: [i32;4] = std::mem::transmute::<__m128i, [i32;4]>(r);
    }
    if crate::get_fuzzing() { info!("Starting fuzzing"); for _ in 0..crate::cpu::get_iterations() { unsafe { let _ = _mm_srav_epi32(_mm_set1_epi32(get_random_i32_array::<4>()[0]), _mm_set1_epi32(1)); } } }
    Ok(())
}

fn test_mm_maskz_srav_epi32() -> Result<(), String> { test_mm_mask_srav_epi32() }

fn test_mm_srav_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(16,8);
        let b = _mm_set1_epi64x(1);
        let r = _mm_srav_epi64(a,b);
        let _out: [i64;2] = std::mem::transmute::<__m128i, [i64;2]>(r);
    }
    if crate::get_fuzzing() { info!("Starting fuzzing"); for _ in 0..crate::cpu::get_iterations() { unsafe { let _ = _mm_srav_epi64(_mm_set1_epi64x(get_random_i32_array::<4>()[0] as i64), _mm_set1_epi64x(1)); } } }
    Ok(())
}

fn test_mm_mask_srav_epi64() -> Result<(), String> { test_mm_srav_epi64() }

fn test_mm_maskz_srav_epi64() -> Result<(), String> { test_mm_srav_epi64() }

fn test_mm_rolv_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1,2,3,4);
        let b = _mm_set1_epi32(1);
        let r = _mm_rolv_epi32(a,b);
        let _out: [i32;4] = std::mem::transmute::<__m128i, [i32;4]>(r);
    }
    if crate::get_fuzzing() { info!("Starting fuzzing"); for _ in 0..crate::cpu::get_iterations() { unsafe { let _ = _mm_rolv_epi32(_mm_set1_epi32(get_random_i32_array::<4>()[0]), _mm_set1_epi32(1)); } } }
    Ok(())
}
