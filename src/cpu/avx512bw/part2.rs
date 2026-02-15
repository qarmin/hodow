use std::arch::x86_64::*;

use log::info;

use crate::cpu::get_iterations;
use crate::get_fuzzing;

use crate::cpu::common::{check_array_equality, get_random_i32_array};

pub(super) fn test_mm_maskz_adds_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(120,121,122,123,124,125,126,127,-128,-127,-126,-125,-124,-123,-122,-121);
        let b = _mm_set1_epi8(10);
        let r = _mm_adds_epi8(a,b);
        let out: [i8;16] = std::mem::transmute::<__m128i, [i8;16]>(r);
        check_array_equality(&out, &[127i8,127,127,127,127,127,127,127,-118,-117,-116,-115,-114,-113,-112,-111])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_adds_epi8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1)); } } }
    Ok(())
}

pub(super) fn test_mm_mask_sub_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(5,4,3,2,1,0,-1,-2);
        let b = _mm_set1_epi16(1);
        let r = _mm_sub_epi16(a,b);
        let out: [i16;8] = std::mem::transmute::<__m128i, [i16;8]>(r);
        check_array_equality(&out, &[4i16,3,2,1,0,-1,-2,-3])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_sub_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1)); } } }
    Ok(())
}

pub(super) fn test_mm_maskz_sub_epi16() -> Result<(), String> { test_mm_mask_sub_epi16() }

pub(super) fn test_mm_mask_sub_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(10,9,8,7,6,5,4,3,2,1,0,-1,-2,-3,-4,-5);
        let b = _mm_set1_epi8(1);
        let r = _mm_sub_epi8(a,b);
        let out: [i8;16] = std::mem::transmute::<__m128i, [i8;16]>(r);
        check_array_equality(&out, &[9i8,8,7,6,5,4,3,2,1,0,-1,-2,-3,-4,-5,-6])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_sub_epi8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1)); } } }
    Ok(())
}

pub(super) fn test_mm_maskz_sub_epi8() -> Result<(), String> { test_mm_mask_sub_epi8() }

pub(super) fn test_mm_mask_subs_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(65535u16 as i16,60000,1000,2,3,4,5,6);
        let b = _mm_set1_epi16(1000);
        let r = _mm_subs_epu16(a,b);
        let out: [u16;8] = std::mem::transmute::<__m128i, [u16;8]>(r);
        check_array_equality(&out, &[64535u16,59000,0,0,0,0,0,0])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_subs_epu16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1)); } } }
    Ok(())
}

pub(super) fn test_mm_maskz_subs_epu16() -> Result<(), String> { test_mm_mask_subs_epu16() }

pub(super) fn test_mm_mask_subs_epu8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(255u8 as i8,250,200,100,10,9,8,7,6,5,4,3,2,1,0,0);
        let b = _mm_set1_epi8(10);
        let r = _mm_subs_epu8(a,b);
        let out: [u8;16] = std::mem::transmute::<__m128i, [u8;16]>(r);
        check_array_equality(&out, &[245u8,240,190,90,0,0,0,0,0,0,0,0,0,0,0,0])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_subs_epu8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1)); } } }
    Ok(())
}

pub(super) fn test_mm_maskz_subs_epu8() -> Result<(), String> { test_mm_mask_subs_epu8() }

pub(super) fn test_mm_mask_subs_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(32767,30000,-30000,-32768,100,200,300,400);
        let b = _mm_set1_epi16(10000);
        let r = _mm_subs_epi16(a,b);
        let out: [i16;8] = std::mem::transmute::<__m128i, [i16;8]>(r);
        check_array_equality(&out, &[22767i16,20000,-32768,-32768,0,100,200,300])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_subs_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1)); } } }
    Ok(())
}

pub(super) fn test_mm_maskz_subs_epi16() -> Result<(), String> { test_mm_mask_subs_epi16() }

pub(super) fn test_mm_mask_subs_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(127,120,100,50,10,5,0,-5,-10,-20,-30,-40,-50,-60,-70,-80);
        let b = _mm_set1_epi8(100);
        let r = _mm_subs_epi8(a,b);
        let out: [i8;16] = std::mem::transmute::<__m128i, [i8;16]>(r);
        check_array_equality(&out, &[27i8,20,0,0,0,0,0,-105,-110,-120,-127,-128,-128,-128,-128,-128])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_subs_epi8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(1)); } } }
    Ok(())
}

pub(super) fn test_mm_maskz_subs_epi8() -> Result<(), String> { test_mm_mask_subs_epi8() }

pub(super) fn test_mm_mask_mulhi_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(65535u16 as i16, 5000, 1000, 2, 3, 4, 5, 6);
        let b = _mm_set1_epi16(2);
        let r = _mm_mulhi_epu16(a,b);
        let out: [u16;8] = std::mem::transmute::<__m128i, [u16;8]>(r);
        check_array_equality(&out, &[65535u16, 152, 0, 0,0,0,0,0])?;
    }
    if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { unsafe { let _ = _mm_mulhi_epu16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(2)); } } }
    Ok(())
}
