use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality, get_random_float32_array, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_cvtepi32_ph() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(4, 3, 2, 1);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[4, 3, 2, 1])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvti32_sh() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_ps(3.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_float_array_equality(&out, &[3.0, 3.0, 3.0, 3.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set1_ps(get_random_float32_array::<1>()[0]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundi32_sh() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_ps(2.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_float_array_equality(&out, &[2.0, 2.0, 2.0, 2.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set1_ps(get_random_float32_array::<1>()[0]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtepu32_ph() -> Result<(), String> {
    test_mm_maskz_cvtepi32_ph()
}
pub(super) fn test_mm_mask_cvtepu32_ph() -> Result<(), String> {
    test_mm_maskz_cvtepi32_ph()
}
pub(super) fn test_mm_maskz_cvtepu32_ph() -> Result<(), String> {
    test_mm_maskz_cvtepi32_ph()
}

pub(super) fn test_mm_cvtu32_sh() -> Result<(), String> {
    test_mm_cvti32_sh()
}
pub(super) fn test_mm_cvt_roundu32_sh() -> Result<(), String> {
    test_mm_cvti32_sh()
}

pub(super) fn test_mm_cvtepi64_ph() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi64x(2, 1);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(v);
        check_array_equality(&out, &[2, 1])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi64x(r[0] as i64, r[1] as i64);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi64_ph() -> Result<(), String> {
    test_mm_cvtepi64_ph()
}
pub(super) fn test_mm_maskz_cvtepi64_ph() -> Result<(), String> {
    test_mm_cvtepi64_ph()
}

pub(super) fn test_mm_cvtepu64_ph() -> Result<(), String> {
    test_mm_cvtepi64_ph()
}
pub(super) fn test_mm_mask_cvtepu64_ph() -> Result<(), String> {
    test_mm_cvtepi64_ph()
}
pub(super) fn test_mm_maskz_cvtepu64_ph() -> Result<(), String> {
    test_mm_cvtepi64_ph()
}

pub(super) fn test_mm_cvtxps_ph() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_float_array_equality(&out, &[4.0, 3.0, 2.0, 1.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ps(
                    get_random_float32_array::<4>()[0],
                    get_random_float32_array::<4>()[1],
                    get_random_float32_array::<4>()[2],
                    get_random_float32_array::<4>()[3],
                );
            }
        }
    }
    Ok(())
}
