use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_int_equality, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_cmp_epi16_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set1_epi16(4);
        let m = _mm_cmp_epi16_mask(a, b, _MM_CMPINT_LT);
        let _ = m;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmp_epi16_mask(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1), _MM_CMPINT_LT);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmp_epi8_mask() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(5);
        let b = _mm_set1_epi8(3);
        let m = _mm_cmp_epi8_mask(a, b, _MM_CMPINT_LT);
        let _ = m;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_cmp_epi8_mask(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1), _MM_CMPINT_LT);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmp_epi8_mask() -> Result<(), String> {
    test_mm_cmp_epi8_mask()
}

pub(super) fn test_mm_reduce_add_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let r = _mm_reduce_add_epi16(a);
        check_int_equality(r, 36)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_reduce_add_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_add_epi16() -> Result<(), String> {
    test_mm_reduce_add_epi16()
}

pub(super) fn test_mm_reduce_add_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 1, 1, 1, 1, 1, 1, 1, 1);
        let r = _mm_reduce_add_epi8(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_reduce_add_epi8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_add_epi8() -> Result<(), String> {
    test_mm_reduce_add_epi8()
}

pub(super) fn test_mm_reduce_and_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(0x02, 0x0, 0xFF, 0x0, 0xAB, 0x0, 0xC, 0x0);
        let r = _mm_reduce_and_epi16(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_reduce_and_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_and_epi16() -> Result<(), String> {
    test_mm_reduce_and_epi16()
}

pub(super) fn test_mm_reduce_and_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(0x26, 0x0, 0x25, 0x0, 0x22, 0x0, 0x02, 0x0, 0x18, 0x0, 0x12, 0x0, 0x16, 0x0, 0x17, 0x0);
        let r = _mm_reduce_and_epi8(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_reduce_and_epi8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_and_epi8() -> Result<(), String> {
    test_mm_reduce_and_epi8()
}

pub(super) fn test_mm_reduce_max_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(100, 90, 80, 70, 60, 50, 40, 30);
        let r = _mm_reduce_max_epi16(a);
        check_array_equality(&[r as i16], &[100i16])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_reduce_max_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_max_epi16() -> Result<(), String> {
    test_mm_reduce_max_epi16()
}

pub(super) fn test_mm_reduce_max_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(127, 120, 100, 50, 10, 5, 0, -5, -10, -20, -30, -40, -50, -60, -70, -80);
        let r = _mm_reduce_max_epi8(a);
        let _ = r;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_reduce_max_epi8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_max_epi8() -> Result<(), String> {
    test_mm_reduce_max_epi8()
}
