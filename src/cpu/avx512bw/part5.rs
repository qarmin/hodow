use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_int_equality, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_cmpgt_epu16_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(10, 20, 30, 40, 50, 60, 70, 80);
        let b = _mm_set1_epi16(25);
        let m = _mm_cmpgt_epu16_mask(a, b);
        check_int_equality(m as i32, 0b11110000)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmpgt_epu16_mask(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpgt_epu16_mask() -> Result<(), String> {
    test_mm_cmpgt_epu16_mask()
}

pub(super) fn test_mm_cmpgt_epu8_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 250, 251, 252, 253, 254, 5, 6, 7, 8, 9, 10, 11, 12);
        let b = _mm_set1_epi8(100);
        let m = _mm_cmpgt_epu8_mask(a, b);
        check_int_equality(m as i32, 0b11100000)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmpgt_epu8_mask(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpgt_epu8_mask() -> Result<(), String> {
    test_mm_cmpgt_epu8_mask()
}

pub(super) fn test_mm_cmpgt_epi16_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set1_epi16(4);
        let m = _mm_cmpgt_epi16_mask(a, b);
        check_int_equality(m as i32, 0b11100000)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmpgt_epi16_mask(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpgt_epi16_mask() -> Result<(), String> {
    test_mm_cmpgt_epi16_mask()
}

pub(super) fn test_mm_cmpgt_epi8_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 100, 101, 102, 103, 104, 105, 106, 107);
        let b = _mm_set1_epi8(50);
        let m = _mm_cmpgt_epi8_mask(a, b);
        check_int_equality(m as i32, 0b00001111)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmpgt_epi8_mask(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpgt_epi8_mask() -> Result<(), String> {
    test_mm_cmpgt_epi8_mask()
}

pub(super) fn test_mm_cmple_epu16_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set1_epi16(5);
        let m = _mm_cmple_epu16_mask(a, b);
        check_int_equality(m as i32, 0b11110000)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmple_epu16_mask(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmple_epu16_mask() -> Result<(), String> {
    test_mm_cmple_epu16_mask()
}

pub(super) fn test_mm_cmple_epu8_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set1_epi8(8);
        let m = _mm_cmple_epu8_mask(a, b);
        check_int_equality(m as i32, 0b11111111)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmple_epu8_mask(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmple_epu8_mask() -> Result<(), String> {
    test_mm_cmple_epu8_mask()
}

pub(super) fn test_mm_cmple_epi16_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(-1, -2, -3, -4, -5, -6, -7, -8);
        let b = _mm_set1_epi16(0);
        let m = _mm_cmple_epi16_mask(a, b);
        check_int_equality(m as i32, 0b11111111)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmple_epi16_mask(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmple_epi16_mask() -> Result<(), String> {
    test_mm_cmple_epi16_mask()
}

pub(super) fn test_mm_cmple_epi8_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(-1, -2, -3, -4, -5, -6, -7, -8, 1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set1_epi8(0);
        let m = _mm_cmple_epi8_mask(a, b);
        check_int_equality(m as i32, 0b11111111)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmple_epi8_mask(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(0));
            }
        }
    }
    Ok(())
}

