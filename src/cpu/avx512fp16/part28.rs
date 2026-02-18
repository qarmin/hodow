use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_i32_array, check_int_equality};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_cvtsh_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(3.5);
        let r = _mm_cvtsh_sd(_mm_set1_pd(1.0), a);
        let _out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvtsh_sd(_mm_set1_pd(1.0), _mm_set1_ps(get_random_i32_array::<4>()[0] as f32));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsh_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(4.25);
        let r = _mm_cvt_roundsh_sd(_mm_set1_pd(1.0), a);
        let _out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvt_roundsh_sd(_mm_set1_pd(1.0), _mm_set1_ps(get_random_i32_array::<4>()[0] as f32));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvt_roundsh_sd() -> Result<(), String> {
    test_mm_cvt_roundsh_sd()
}

pub(super) fn test_mm_maskz_cvt_roundsh_sd() -> Result<(), String> {
    test_mm_cvt_roundsh_sd()
}

pub(super) fn test_mm_cvtsh_h() -> Result<(), String> {
    unsafe {
        let v = _mm_set1_ps(2.5);
        let r = _mm_cvtsh_h(v);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvtsh_h(_mm_set1_ps(get_random_i32_array::<4>()[0] as f32));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsi128_si16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let r = _mm_cvtsi128_si16(a);
        check_int_equality(r as i16, 8)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvtsi128_si16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsi16_si128() -> Result<(), String> {
    unsafe {
        let r = _mm_cvtsi16_si128(5);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        check_array_equality(&out, &[5, 0, 0, 0, 0, 0, 0, 0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cvtsi16_si128(get_random_i32_array::<4>()[0] as i16);
            }
        }
    }
    Ok(())
}
