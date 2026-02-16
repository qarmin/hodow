use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_madd_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1, 2, 3, 4, 5, 6, 7, 8);
        let _b = _mm_set1_epi16(2);
        let r = _mm_madd_epi16(a, _b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[6i32, 14, 22, 30])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_madd_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_madd_epi16() -> Result<(), String> {
    test_mm_mask_madd_epi16()
}

pub(super) fn test_mm_mask_maddubs_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 1, 2, 3, 4);
        let b = _mm_set1_epi16(1);
        let r = _mm_maddubs_epi16(a, _mm_set1_epi8(1));
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        let _out = out;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_maddubs_epi16(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_maddubs_epi16() -> Result<(), String> {
    test_mm_mask_maddubs_epi16()
}

pub(super) fn test_mm_mask_packs_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(30000, 20000, 10000, 0);
        let r = _mm_packs_epi32(a, a);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(r);
        check_array_equality(&out, &[32767i16, 20000, 10000, 0, 32767i16, 20000, 10000, 0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_packs_epi32(_mm_set1_epi32(get_random_i32_array::<4>()[0]), _mm_set1_epi32(0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_packs_epi32() -> Result<(), String> {
    test_mm_mask_packs_epi32()
}

pub(super) fn test_mm_mask_packs_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(300, 200, 100, 0, -300, -200, -100, 0);
        let r = _mm_packs_epi16(a, a);
        let out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(r);
        let _out = out;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_packs_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_packs_epi16() -> Result<(), String> {
    test_mm_mask_packs_epi16()
}

pub(super) fn test_mm_mask_packus_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(70000, 60000, 50000, 40000);
        let r = _mm_packus_epi32(a, a);
        let out: [u16; 8] = std::mem::transmute::<__m128i, [u16; 8]>(r);
        let _out = out;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_packus_epi32(_mm_set1_epi32(get_random_i32_array::<4>()[0]), _mm_set1_epi32(0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_packus_epi32() -> Result<(), String> {
    test_mm_mask_packus_epi32()
}

pub(super) fn test_mm_mask_packus_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(700, 600, 500, 400, 300, 200, 100, 0);
        let r = _mm_packus_epi16(a, a);
        let out: [u16; 8] = std::mem::transmute::<__m128i, [u16; 8]>(r);
        let _out = out;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_packus_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_packus_epi16() -> Result<(), String> {
    test_mm_mask_packus_epi16()
}

pub(super) fn test_mm_mask_avg_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(100, 90, 80, 70, 60, 50, 40, 30);
        let b = _mm_set1_epi16(10);
        let r = _mm_avg_epu16(a, b);
        let out: [u16; 8] = std::mem::transmute::<__m128i, [u16; 8]>(r);
        check_array_equality(&out, &[55u16, 50, 45, 40, 35, 30, 25, 20])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_avg_epu16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_avg_epu16() -> Result<(), String> {
    test_mm_mask_avg_epu16()
}

pub(super) fn test_mm_mask_avg_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(200u8 as i8, 180, 160, 140, 120, 100, 80, 60, 40, 20, 10, 9, 8, 7, 6, 5);
        let b = _mm_set1_epi8(10);
        let r = _mm_avg_epu8(a, b);
        let out: [u8; 16] = std::mem::transmute::<__m128i, [u8; 16]>(r);
        let _out = out;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_avg_epu8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1));
            }
        }
    }
    Ok(())
}
