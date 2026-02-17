use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_blend_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set_epi8(16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1);
        // mask is __mmask16 -> use u16 literal
        let r = _mm_mask_blend_epi8(170, a, b);
        let _out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                // mask is __mmask16 -> use u16 literal
                let _ = _mm_mask_blend_epi8(170, _mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_broadcastw_epi16() -> Result<(), String> {
    unsafe {
        let r = _mm_mask_broadcastw_epi16(_mm_set1_epi16(0), 0, _mm_set1_epi16(7));
        let _out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_mask_broadcastw_epi16(_mm_set1_epi16(0), 0, _mm_set1_epi16(get_random_i32_array::<4>()[0] as i16));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_broadcastw_epi16() -> Result<(), String> {
    test_mm_mask_broadcastw_epi16()
}

pub(super) fn test_mm_mask_broadcastb_epi8() -> Result<(), String> {
    unsafe {
        let r = _mm_mask_broadcastb_epi8(_mm_set1_epi8(0), 0, _mm_set1_epi8(5));
        let _out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(r);
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_mask_broadcastb_epi8(_mm_set1_epi8(0), 0, _mm_set1_epi8(get_random_i32_array::<4>()[0] as i8));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_broadcastb_epi8() -> Result<(), String> {
    test_mm_mask_broadcastb_epi8()
}

pub(super) fn test_mm_mask_unpackhi_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set1_epi16(9);
        let r = _mm_unpackhi_epi16(a, b);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        let _ = out;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_unpackhi_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_unpackhi_epi16() -> Result<(), String> {
    test_mm_mask_unpackhi_epi16()
}

pub(super) fn test_mm_mask_unpackhi_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set1_epi8(17);
        let r = _mm_unpackhi_epi8(a, b);
        let out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(r);
        let _ = out;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_unpackhi_epi8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_unpackhi_epi8() -> Result<(), String> {
    test_mm_mask_unpackhi_epi8()
}

pub(super) fn test_mm_mask_unpacklo_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let b = _mm_set1_epi16(9);
        let r = _mm_unpacklo_epi16(a, b);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        let _ = out;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_unpacklo_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_unpacklo_epi16() -> Result<(), String> {
    test_mm_mask_unpacklo_epi16()
}

pub(super) fn test_mm_mask_unpacklo_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let b = _mm_set1_epi8(17);
        let r = _mm_unpacklo_epi8(a, b);
        let out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(r);
        let _ = out;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_unpacklo_epi8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_unpacklo_epi8() -> Result<(), String> {
    test_mm_mask_unpacklo_epi8()
}

pub(super) fn test_mm_mask_mov_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        // second argument is a mask (__mmask8), pass scalar u8 instead of __m128i
        let r = _mm_mask_mov_epi16(a, 0, a);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        check_array_equality(&out, &[1, 2, 3, 4, 5, 6, 7, 8])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                // mask is __mmask8 -> use scalar u8
                let _ = _mm_mask_mov_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), 1, _mm_set1_epi16(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mov_epi16() -> Result<(), String> {
    test_mm_mask_mov_epi16()
}
