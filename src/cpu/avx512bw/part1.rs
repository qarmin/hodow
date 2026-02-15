use std::arch::x86_64::*;

use log::info;

use crate::cpu::get_iterations;
use crate::get_fuzzing;

use crate::cpu::common::{check_array_equality, get_random_i32_array};

pub(super) fn test_mm_mask_abs_epi16() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi16(-1, -2, -3, -4, 5, 6, 7, 8);
        let out: [i16; 8] = std::mem::transmute::<__m128i, [i16; 8]>(v);
        check_array_equality(&out, &[-1i16, -2, -3, -4, 5, 6, 7, 8])?;
        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let _ = _mm_set1_epi16(get_random_i32_array::<4>()[0] as i16);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_abs_epi16() -> Result<(), String> { test_mm_mask_abs_epi16() }

pub(super) fn test_mm_mask_abs_epi8() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi8(-1, -2, -3, -4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16);
        let out: [i8; 16] = std::mem::transmute::<__m128i, [i8; 16]>(v);
        check_array_equality(&out, &[-1i8, -2, -3, -4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])?;
        if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { let _ = _mm_set1_epi8(get_random_i32_array::<4>()[0] as i8); } }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_abs_epi8() -> Result<(), String> { test_mm_mask_abs_epi8() }

pub(super) fn test_mm_mask_add_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1,2,3,4,5,6,7,8);
        let b = _mm_set1_epi16(1);
        let r = _mm_add_epi16(a,b);
        let out: [i16;8] = std::mem::transmute::<__m128i, [i16;8]>(r);
        check_array_equality(&out, &[2i16,3,4,5,6,7,8,9])?;
        if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { let _ = _mm_add_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1)); } }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_add_epi16() -> Result<(), String> { test_mm_mask_add_epi16() }

pub(super) fn test_mm_mask_add_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16);
        let b = _mm_set1_epi8(1);
        let r = _mm_add_epi8(a,b);
        let out: [i8;16] = std::mem::transmute::<__m128i, [i8;16]>(r);
        check_array_equality(&out, &[2i8,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17])?;
        if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { let _ = _mm_add_epi8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1)); } }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_add_epi8() -> Result<(), String> { test_mm_mask_add_epi8() }

pub(super) fn test_mm_mask_adds_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(60000,60000,1,2,3,4,5,6);
        let b = _mm_set1_epi16(1000);
        let r = _mm_adds_epu16(a,b);
        let out: [u16;8] = std::mem::transmute::<__m128i, [u16;8]>(r);
        check_array_equality(&out, &[65535u16,65535,1001,1002,1003,1004,1005,1006])?;
        if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { let _ = _mm_adds_epu16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1)); } }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_adds_epu16() -> Result<(), String> { test_mm_mask_adds_epu16() }

pub(super) fn test_mm_mask_adds_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(250,251,252,253,254,255,1,2,3,4,5,6,7,8,9,10);
        let b = _mm_set1_epi8(10);
        let r = _mm_adds_epu8(a,b);
        let out: [u8;16] = std::mem::transmute::<__m128i, [u8;16]>(r);
        check_array_equality(&out, &[255u8,255,255,255,255,255,11,12,13,14,15,16,17,18,19,20])?;
        if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { let _ = _mm_adds_epu8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1)); } }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_adds_epu8() -> Result<(), String> { test_mm_mask_adds_epu8() }

pub(super) fn test_mm_mask_adds_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(30000,30000,-30000,-30000,1,2,3,4);
        let b = _mm_set1_epi16(10000);
        let r = _mm_adds_epi16(a,b);
        let out: [i16;8] = std::mem::transmute::<__m128i, [i16;8]>(r);
        check_array_equality(&out, &[32767i16,32767, -20000, -20000,10001,10002,10003,10004])?;
        if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { let _ = _mm_adds_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1)); } }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_adds_epi16() -> Result<(), String> { test_mm_mask_adds_epi16() }

pub(super) fn test_mm_mask_adds_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(120,121,122,123,124,125,126,127,-128,-127,-126,-125,-124,-123,-122,-121);
        let b = _mm_set1_epi8(10);
        let r = _mm_adds_epi8(a,b);
        let out: [i8;16] = std::mem::transmute::<__m128i, [i8;16]>(r);
        check_array_equality(&out, &[127i8,127,127,127,127,127,127,127,-118,-117,-116,-115,-114,-113,-112,-111])?;
        if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { let _ = _mm_adds_epi8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1)); } }
    }
    Ok(())
}
