use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_min_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(100_i16, 50, 10, 5, 4, 3, 2, 1);
        let b = _mm_set1_epi16(20);
        let r = _mm_min_epu16(a, b);
        let out: [u16; 8] = std::mem::transmute::<__m128i, [u16; 8]>(r);
        check_array_equality(&out, &[20, 20, 10, 5, 4, 3, 2, 1])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_min_epu16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_min_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(20, 120, 100, 50, 10, 5, 4, 3, 2, 1, 0, 0, 0, 0, 0, 0);
        let b = _mm_set1_epi8(20);
        let r = _mm_min_epu8(a, b);
        let out: [u8; 16] = std::mem::transmute::<__m128i, [u8; 16]>(r);
        check_array_equality(&out, &[20, 20, 20, 20, 10, 5, 4, 3, 2, 1, 0, 0, 0, 0, 0, 0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_min_epu8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_min_epu8() -> Result<(), String> {
    test_mm_mask_min_epu8()
}

pub(super) fn test_mm_mask_min_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(100, 50, 10, 5, -1, -2, -3, -4);
        let b = _mm_set1_epi16(20);
        let r = _mm_min_epi16(a, b);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        check_array_equality(&out, &[20, 20, 10, 5, -1, -2, -3, -4])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_min_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_min_epi16() -> Result<(), String> {
    test_mm_mask_min_epi16()
}

pub(super) fn test_mm_mask_min_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(100, 80, 60, 40, 20, 10, 5, 4, 3, 2, 1, 0, -1, -2, -3, -4);
        let b = _mm_set1_epi8(30);
        let r = _mm_min_epi8(a, b);
        let out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(r);
        check_array_equality(&out, &[30, 30, 30, 30, 20, 10, 5, 4, 3, 2, 1, 0, -1, -2, -3, -4])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_min_epi8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_min_epi8() -> Result<(), String> {
    test_mm_mask_min_epi8()
}

pub(super) fn test_mm_cmplt_epu16_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set1_epi16(4);
        let m = _mm_cmplt_epu16_mask(a, b);
        let _ = m;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmplt_epu16_mask(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmplt_epu16_mask() -> Result<(), String> {
    test_mm_cmplt_epu16_mask()
}

pub(super) fn test_mm_cmplt_epu8_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set1_epi8(10);
        let m = _mm_cmplt_epu8_mask(a, b);
        let _ = m;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmplt_epu8_mask(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmplt_epu8_mask() -> Result<(), String> {
    test_mm_cmplt_epu8_mask()
}

pub(super) fn test_mm_cmplt_epi16_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set1_epi16(4);
        let m = _mm_cmplt_epi16_mask(a, b);
        let _ = m;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmplt_epi16_mask(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmplt_epi16_mask() -> Result<(), String> {
    test_mm_cmplt_epi16_mask()
}

pub(super) fn test_mm_cmplt_epi8_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set1_epi8(10);
        let m = _mm_cmplt_epi8_mask(a, b);
        let _ = m;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmplt_epi8_mask(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmplt_epi8_mask() -> Result<(), String> {
    test_mm_cmplt_epi8_mask()
}
