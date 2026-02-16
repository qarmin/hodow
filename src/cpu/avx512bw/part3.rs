use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_mulhi_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(65535u16 as i16, 5000, 1000, 2, 3, 4, 5, 6);
        let b = _mm_set1_epi16(2);
        let r = _mm_mulhi_epi16(a, b);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        let _ = out;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_mulhi_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(2));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mulhi_epi16() -> Result<(), String> {
    test_mm_mask_mulhi_epi16()
}

pub(super) fn test_mm_mask_mulhrs_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(30000, 20000, 10000, 5000, 1000, 500, 200, 100);
        let b = _mm_set1_epi16(2);
        let r = _mm_mulhrs_epi16(a, b);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        let _ = out;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_mulhrs_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(2));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mulhrs_epi16() -> Result<(), String> {
    test_mm_mask_mulhrs_epi16()
}

pub(super) fn test_mm_mask_mullo_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set1_epi16(2);
        let r = _mm_mullo_epi16(a, b);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        check_array_equality(&out, &[2i16, 4, 6, 8, 10, 12, 14, 16])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_mullo_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(2));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mullo_epi16() -> Result<(), String> {
    test_mm_mask_mullo_epi16()
}

pub(super) fn test_mm_mask_max_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 50, 3, 4, 5, 6, 7, 8);
        let b = _mm_set1_epi16(10);
        let r = _mm_max_epu16(a, b);
        let out: [u16; 8] = std::mem::transmute::<__m128i, [u16; 8]>(r);
        let _ = out;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_max_epu16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_max_epu16() -> Result<(), String> {
    test_mm_mask_max_epu16()
}

pub(super) fn test_mm_mask_max_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(20, 120, 100, 50, 10, 5, 4, 3, 2, 1, 0, 0, 0, 0, 0, 0);
        let b = _mm_set1_epi8(20);
        let r = _mm_max_epu8(a, b);
        let out: [u8; 16] = std::mem::transmute::<__m128i, [u8; 16]>(r);
        let _ = out;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_max_epu8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_max_epu8() -> Result<(), String> {
    test_mm_mask_max_epu8()
}

pub(super) fn test_mm_mask_max_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 50, 3, 4, 5, 6, 7, 8);
        let b = _mm_set1_epi16(10);
        let r = _mm_max_epi16(a, b);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        let _ = out;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_max_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_max_epi16() -> Result<(), String> {
    test_mm_mask_max_epi16()
}

pub(super) fn test_mm_mask_max_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(127, 120, 100, 50, 10, 5, 0, -5, -10, -20, -30, -40, -50, -60, -70, -80);
        let b = _mm_set1_epi8(10);
        let r = _mm_max_epi8(a, b);
        let out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(r);
        let _ = out;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_max_epi8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_max_epi8() -> Result<(), String> {
    test_mm_mask_max_epi8()
}

pub(super) fn test_mm_mask_min_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set1_epi16(4);
        let r = _mm_min_epu16(a, b);
        let out: [u16; 8] = std::mem::transmute::<__m128i, [u16; 8]>(r);
        let _ = out;
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
