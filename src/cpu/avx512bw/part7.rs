use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_int_equality, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_cmpeq_epi8_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8);
        let b = _mm_set1_epi8(8);
        let m = _mm_cmpeq_epi8_mask(a, b);
        check_int_equality(m as i32, 0b11111111)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmpeq_epi8_mask(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpeq_epi8_mask() -> Result<(), String> {
    test_mm_cmpeq_epi8_mask()
}

pub(super) fn test_mm_cmpneq_epu16_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set1_epi16(4);
        let m = _mm_cmpneq_epu16_mask(a, b);
        check_int_equality(m as i32, 0b11101111)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmpneq_epu16_mask(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpneq_epu16_mask() -> Result<(), String> {
    test_mm_cmpneq_epu16_mask()
}

pub(super) fn test_mm_cmpneq_epu8_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set1_epi8(8);
        let m = _mm_cmpneq_epu8_mask(a, b);
        check_int_equality(m as i32, 0b00000000)?;
    }
    if get_fuzzing() {
        info!("Starting fluffing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmpneq_epu8_mask(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpneq_epu8_mask() -> Result<(), String> {
    test_mm_cmpneq_epu8_mask()
}

pub(super) fn test_mm_cmpneq_epi16_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 4, 6, 7, 8);
        let b = _mm_set1_epi16(4);
        let m = _mm_cmpneq_epi16_mask(a, b);
        check_int_equality(m as i32, 0b11101101)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmpneq_epi16_mask(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpneq_epi16_mask() -> Result<(), String> {
    test_mm_cmpneq_epi16_mask()
}

pub(super) fn test_mm_cmpneq_epi8_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8);
        let b = _mm_set1_epi8(8);
        let m = _mm_cmpneq_epi8_mask(a, b);
        check_int_equality(m as i32, 0b00000000)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmpneq_epi8_mask(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmpneq_epi8_mask() -> Result<(), String> {
    test_mm_cmpneq_epi8_mask()
}

pub(super) fn test_mm_cmp_epu16_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set1_epi16(4);
        let m = _mm_cmp_epu16_mask::<0>(a, b);
        check_int_equality(m as i32, 0b00010000)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmp_epu16_mask::<0>(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmp_epu16_mask() -> Result<(), String> {
    test_mm_cmp_epu16_mask()
}

pub(super) fn test_mm_cmp_epu8_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8);
        let b = _mm_set1_epi8(8);
        let m = _mm_cmp_epu8_mask::<0>(a, b);
        check_int_equality(m as i32, 0b11111111)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmp_epu8_mask::<0>(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmp_epu8_mask() -> Result<(), String> {
    test_mm_cmp_epu8_mask()
}

pub(super) fn test_mm_cmp_epi16_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set1_epi16(4);
        let m = _mm_cmp_epi16_mask::<0>(a, b);
        check_int_equality(m as i32, 0b00010000)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmp_epi16_mask::<0>(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1));
            }
        }
    }
    Ok(())
}
