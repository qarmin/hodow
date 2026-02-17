use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_avg_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set_epi8(16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1);
        let r = _mm_avg_epu8(a, b);
        let out: [u8; 16] = std::mem::transmute::<__m128i, [u8; 16]>(r);
        check_array_equality(&out, &[9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_avg_epu8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_sll_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let r = _mm_sll_epi16(a, _mm_set1_epi64x(1));
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        check_array_equality(&out, &[2, 4, 6, 8, 10, 12, 14, 16])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_sll_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi64x(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_sll_epi16() -> Result<(), String> {
    test_mm_mask_sll_epi16()
}

pub(super) fn test_mm_mask_slli_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(2);
        let r = _mm_slli_epi16(a, 1);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        check_array_equality(&out, &[4, 4, 4, 4, 4, 4, 4, 4])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_slli_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), 1);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_slli_epi16() -> Result<(), String> {
    test_mm_mask_slli_epi16()
}

pub(super) fn test_mm_sllv_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let count = _mm_set_epi16(1, 1, 1, 1, 1, 1, 1, 1);
        let r = _mm_sllv_epi16(a, count);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        check_array_equality(&out, &[2, 4, 6, 8, 10, 12, 14, 16])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_sllv_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_sllv_epi16() -> Result<(), String> {
    test_mm_sllv_epi16()
}

pub(super) fn test_mm_maskz_sllv_epi16() -> Result<(), String> {
    test_mm_sllv_epi16()
}

pub(super) fn test_mm_mask_srl_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(2, 4, 6, 8, 10, 12, 14, 16);
        let r = _mm_srl_epi16(a, _mm_set1_epi64x(1));
        let out: [u16; 8] = std::mem::transmute::<__m128i, [u16; 8]>(r);
        check_array_equality(&out, &[1, 2, 3, 4, 5, 6, 7, 8])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_srl_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi64x(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_srl_epi16() -> Result<(), String> {
    test_mm_mask_srl_epi16()
}

pub(super) fn test_mm_mask_srli_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi16(4);
        let r = _mm_srli_epi16(a, 1);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        check_array_equality(&out, &[2, 2, 2, 2, 2, 2, 2, 2])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_srli_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), 1);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_srli_epi16() -> Result<(), String> {
    test_mm_mask_srli_epi16()
}

pub(super) fn test_mm_srlv_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(2, 4, 6, 8, 10, 12, 14, 16);
        let count = _mm_set_epi16(1, 1, 1, 1, 1, 1, 1, 1);
        let r = _mm_srlv_epi16(a, count);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        check_array_equality(&out, &[1, 2, 3, 4, 5, 6, 7, 8])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_srlv_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_srlv_epi16() -> Result<(), String> {
    test_mm_srlv_epi16()
}

pub(super) fn test_mm_maskz_srlv_epi16() -> Result<(), String> {
    test_mm_srlv_epi16()
}
