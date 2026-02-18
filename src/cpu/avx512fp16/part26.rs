use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_float32_array, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_cvttph_epu32() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_ps(3.0);
        let r = _mm_cvttph_epu32(_mm_cvtps_ph(v));
        let out: [u32; 4] = std::mem::transmute::<__m128i, [u32; 4]>(r);
        check_array_equality(&out, &[3; 4])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvttph_epu32(_mm_cvtps_ph(_mm_set1_ps(get_random_float32_array::<1>()[0])));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvttph_epu32() -> Result<(), String> {
    test_mm_mask_cvttph_epu32()
}

pub(super) fn test_mm_cvttsh_u32() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_ps(4.0);
        let r = _mm_cvttsh_u32(_mm_cvtps_ph(v));
        crate::cpu::common::check_int_equality(r as i32, 4)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvttsh_u32(_mm_cvtps_ph(_mm_set1_ps(get_random_float32_array::<1>()[0])));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundsh_u32() -> Result<(), String> {
    test_mm_cvttsh_u32()
}

pub(super) fn test_mm_cvtph_epi64() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_ps(5.0);
        let r = _mm_cvtph_epi64(_mm_cvtps_ph(v));
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[5, 5])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvtph_epi64(_mm_cvtps_ph(_mm_set1_ps(get_random_float32_array::<1>()[0])));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtph_epi64() -> Result<(), String> {
    test_mm_cvtph_epi64()
}

pub(super) fn test_mm_maskz_cvtph_epi64() -> Result<(), String> {
    test_mm_cvtph_epi64()
}

pub(super) fn test_mm_cvtph_epu64() -> Result<(), String> {
    test_mm_cvtph_epi64()
}

pub(super) fn test_mm_mask_cvtph_epu64() -> Result<(), String> {
    test_mm_cvtph_epi64()
}

pub(super) fn test_mm_maskz_cvtph_epu64() -> Result<(), String> {
    test_mm_cvtph_epi64()
}

pub(super) fn test_mm_cvttph_epi64() -> Result<(), String> {
    unsafe {
        let v = _mm_cvtps_ph(_mm_set1_ps(6.0));
        let r = _mm_cvttph_epi64(v);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[6, 6])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvttph_epi64(_mm_cvtps_ph(_mm_set1_ps(get_random_float32_array::<1>()[0])));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvttph_epi64() -> Result<(), String> {
    test_mm_cvttph_epi64()
}

pub(super) fn test_mm_maskz_cvttph_epi64() -> Result<(), String> {
    test_mm_cvttph_epi64()
}

pub(super) fn test_mm_cvttph_epu64() -> Result<(), String> {
    test_mm_cvttph_epi64()
}

pub(super) fn test_mm_mask_cvttph_epu64() -> Result<(), String> {
    test_mm_cvttph_epi64()
}
