use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality, get_random_float32_array, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_fpclass_ph_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, f32::NAN, f32::INFINITY, -0.0);
        let m = _mm_fpclass_ph_mask(a, _FPCLASS_SNAN | _FPCLASS_INF);
        let _ = m;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_fpclass_ph_mask(_mm_set1_ps(get_random_float32_array::<1>()[0]), _FPCLASS_SNAN | _FPCLASS_INF);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fpclass_ph_mask() -> Result<(), String> {
    test_mm_fpclass_ph_mask()
}

pub(super) fn test_mm_fpclass_sh_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(3.1415);
        let m = _mm_fpclass_sh_mask(a, _FPCLASS_FINITE);
        let _ = m;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_fpclass_sh_mask(_mm_set1_ps(get_random_float32_array::<1>()[0]), _FPCLASS_FINITE);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fpclass_sh_mask() -> Result<(), String> {
    test_mm_fpclass_sh_mask()
}

pub(super) fn test_mm_mask_blend_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let mask = 0b1010u32;
        let r = _mm_mask_blend_ph(mask, a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[5.0, 2.0, 7.0, 4.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_mask_blend_ph(0b1010u32, _mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_permutex2var_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let idx = _mm_set_epi32(0, 1, 2, 3);
        let r = _mm_permutex2var_ph(a, idx, a);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_permutex2var_ph(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set_epi32(0, 1, 2, 3), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_permutexvar_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let idx = _mm_set_epi32(0, 1, 2, 3);
        let r = _mm_permutexvar_ph(idx, a);
        let _out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_permutexvar_ph(_mm_set_epi32(0, 1, 2, 3), _mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtepi16_ph() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let r = _mm_cvtepi16_ph(v);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        check_array_equality(&out, &[1i16, 2, 3, 4, 5, 6, 7, 8])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvtepi16_ph(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi16_ph() -> Result<(), String> {
    test_mm_cvtepi16_ph()
}

pub(super) fn test_mm_maskz_cvtepi16_ph() -> Result<(), String> {
    test_mm_cvtepi16_ph()
}

pub(super) fn test_mm_cvtepu16_ph() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let r = _mm_cvtepu16_ph(v);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        check_array_equality(&out, &[1i16, 2, 3, 4, 5, 6, 7, 8])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvtepu16_ph(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepu16_ph() -> Result<(), String> {
    test_mm_cvtepu16_ph()
}

pub(super) fn test_mm_maskz_cvtepu16_ph() -> Result<(), String> {
    test_mm_cvtepu16_ph()
}

pub(super) fn test_mm_cvtepi32_ph() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(1, 2, 3, 4);
        let r = _mm_cvtepi32_ph(v);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[1i32, 2, 3, 4])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvtepi32_ph(_mm_set1_epi32(get_random_i32_array::<4>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi32_ph() -> Result<(), String> {
    test_mm_cvtepi32_ph()
}
