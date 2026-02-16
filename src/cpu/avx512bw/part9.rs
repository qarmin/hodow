use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_reduce_max_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(100u16 as i16, 90, 80, 70, 60, 50, 40, 30);
        let r = _mm_reduce_max_epu16(a);
        check_array_equality(&[r as u16], &[100u16])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_reduce_max_epu16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_max_epu16() -> Result<(), String> {
    test_mm_reduce_max_epu16()
}

pub(super) fn test_mm_reduce_max_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(200u8 as i8, 150, 100, 50, 40, 30, 20, 10, 9, 8, 7, 6, 5, 4, 3, 2);
        let r = _mm_reduce_max_epu8(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_reduce_max_epu8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_max_epu8() -> Result<(), String> {
    test_mm_reduce_max_epu8()
}

pub(super) fn test_mm_reduce_min_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(100, 90, 80, 70, 60, 50, 40, 30);
        let r = _mm_reduce_min_epi16(a);
        check_array_equality(&[r as i16], &[30i16])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_reduce_min_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_min_epi16() -> Result<(), String> {
    test_mm_reduce_min_epi16()
}

pub(super) fn test_mm_reduce_min_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, -1, -2, -3, -4, -5);
        let r = _mm_reduce_min_epi8(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_reduce_min_epi8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_min_epi8() -> Result<(), String> {
    test_mm_reduce_min_epi8()
}

pub(super) fn test_mm_reduce_min_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(100u16 as i16, 90, 80, 70, 60, 50, 40, 30);
        let r = _mm_reduce_min_epu16(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_reduce_min_epu16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_min_epu16() -> Result<(), String> {
    test_mm_reduce_min_epu16()
}

pub(super) fn test_mm_reduce_min_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, 0, 0, 0, 0, 0);
        let r = _mm_reduce_min_epu8(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_reduce_min_epu8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_min_epu8() -> Result<(), String> {
    test_mm_reduce_min_epu8()
}

pub(super) fn test_mm_reduce_mul_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let r = _mm_reduce_mul_epi16(a);
        check_array_equality(&[r as i16], &[40320i16 % 32768i16])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_reduce_mul_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_mul_epi16() -> Result<(), String> {
    test_mm_reduce_mul_epi16()
}

pub(super) fn test_mm_reduce_mul_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 1, 1, 1, 1, 1, 1, 1, 1);
        let r = _mm_reduce_mul_epi8(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_reduce_mul_epi8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8));
            }
        }
    }
    Ok(())
}
