use std::arch::x86_64::*;

use log::info;

use crate::cpu::get_iterations;
use crate::get_fuzzing;

use crate::cpu::common::{check_array_equality, get_random_i32_array};

pub(super) fn test_mm_blendv_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16);
        let b = _mm_set1_epi8(0);
        let mask = _mm_set1_epi8(-1);
        let r = _mm_blendv_epi8(a,b,mask);
        let out: [i8;16] = std::mem::transmute::<__m128i, [i8;16]>(r);
        check_array_equality(&out, &[1i8,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16])?;
        if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { let _ = _mm_blendv_epi8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), _mm_set1_epi8(0), _mm_set1_epi8(-1)); } }
    }
    Ok(())
}

pub(super) fn test_mm_blend_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(1,2,3,4,5,6,7,8);
        let b = _mm_set1_epi16(0);
        let r = _mm_blend_epi16(a,b,0b10101010);
        let out: [i16;8] = std::mem::transmute::<__m128i, [i16;8]>(r);
        check_array_equality(&out, &[1i16,0,3,0,5,0,7,0])?;
        if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { let _ = _mm_blend_epi16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(0), 0b10101010); } }
    }
    Ok(())
}

pub(super) fn test_mm_blendv_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0,2.0);
        let b = _mm_set1_pd(0.0);
        let mask = _mm_castsi128_pd(_mm_set1_epi64x(-1));
        let r = _mm_blendv_pd(a,b,mask);
        let out: [f64;2] = std::mem::transmute::<__m128d, [f64;2]>(r);
        check_array_equality(&[out[0] as i64, out[1] as i64], &[1i64,2i64]).ok();
        if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { let _ = _mm_blendv_pd(_mm_set1_pd(1.0), _mm_set1_pd(0.0), _mm_set1_pd(-0.0)); } }
    }
    Ok(())
}

pub(super) fn test_mm_blend_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0,2.0);
        let b = _mm_set1_pd(0.0);
        let r = _mm_blend_pd(a,b,0b01);
        let out: [f64;2] = std::mem::transmute::<__m128d, [f64;2]>(r);
        let _ = out;
        if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { let _ = _mm_blend_pd(_mm_set1_pd(1.0), _mm_set1_pd(0.0), 0b01); } }
    }
    Ok(())
}

pub(super) fn test_mm_extract_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16);
        let v = _mm_extract_epi8(a, 0);
        check_array_equality(&[v as i8], &[16i8])?;
        if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { let _ = _mm_extract_epi8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), 0); } }
    }
    Ok(())
}

pub(super) fn test_mm_extract_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(1,2,3,4);
        let v = _mm_extract_epi32(a, 0);
        check_array_equality(&[v as i32], &[4i32])?;
        if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { let _ = _mm_extract_epi32(_mm_set1_epi32(get_random_i32_array::<4>()[0]), 0); } }
    }
    Ok(())
}

pub(super) fn test_mm_insert_epi8() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi8(1);
        let r = _mm_insert_epi8(a, 5, 0);
        let out: [i8;16] = std::mem::transmute::<__m128i, [i8;16]>(r);
        check_array_equality(&out, &[5i8,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1])?;
        if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { let _ = _mm_insert_epi8(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8), 1, 0); } }
    }
    Ok(())
}

pub(super) fn test_mm_insert_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(1);
        let r = _mm_insert_epi32(a, 5, 0);
        let out: [i32;4] = std::mem::transmute::<__m128i, [i32;4]>(r);
        check_array_equality(&out, &[5i32,1,1,1])?;
        if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { let _ = _mm_insert_epi32(_mm_set1_epi32(get_random_i32_array::<4>()[0]), 1, 0); } }
    }
    Ok(())
}

pub(super) fn test_mm_max_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(100u16 as i16,50,10,5,4,3,2,1);
        let b = _mm_set1_epi16(20);
        let r = _mm_max_epu16(a,b);
        let out: [u16;8] = std::mem::transmute::<__m128i, [u16;8]>(r);
        let _ = out;
        if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { let _ = _mm_max_epu16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1)); } }
    }
    Ok(())
}

pub(super) fn test_mm_max_epu32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(100u32 as i32,50,10,5);
        let b = _mm_set1_epi32(20);
        let r = _mm_max_epu32(a,b);
        let out: [u32;4] = std::mem::transmute::<__m128i, [u32;4]>(r);
        let _ = out;
        if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { let _ = _mm_max_epu32(_mm_set1_epi32(get_random_i32_array::<4>()[0]), _mm_set1_epi32(1)); } }
    }
    Ok(())
}

pub(super) fn test_mm_min_epu16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi16(100u16 as i16,50,10,5,4,3,2,1);
        let b = _mm_set1_epi16(20);
        let r = _mm_min_epu16(a,b);
        let out: [u16;8] = std::mem::transmute::<__m128i, [u16;8]>(r);
        let _ = out;
        if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { let _ = _mm_min_epu16(_mm_set1_epi16(get_random_i32_array::<4>()[0] as i16), _mm_set1_epi16(1)); } }
    }
    Ok(())
}

pub(super) fn test_mm_min_epu32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(100u32 as i32,50,10,5);
        let b = _mm_set1_epi32(20);
        let r = _mm_min_epu32(a,b);
        let out: [u32;4] = std::mem::transmute::<__m128i, [u32;4]>(r);
        let _ = out;
        if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { let _ = _mm_min_epu32(_mm_set1_epi32(get_random_i32_array::<4>()[0]), _mm_set1_epi32(1)); } }
    }
    Ok(())
}

pub(super) fn test_mm_packus_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(70000,60000,50000,40000);
        let r = _mm_packus_epi32(a,a);
        let out: [u16;8] = std::mem::transmute::<__m128i, [u16;8]>(r);
        let _ = out;
        if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { let _ = _mm_packus_epi32(_mm_set1_epi32(get_random_i32_array::<4>()[0]), _mm_set1_epi32(0)); } }
    }
    Ok(())
}

pub(super) fn test_mm_cmpeq_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(1,1);
        let r = _mm_cmpeq_epi64(a,a);
        let out: [i64;2] = std::mem::transmute::<__m128i, [i64;2]>(r);
        let _ = out;
        if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { let _ = _mm_cmpeq_epi64(_mm_set1_epi64x(get_random_i32_array::<4>()[0] as i64), _mm_set1_epi64x(1)); } }
    }
    Ok(())
}

pub(super) fn test_mm_cvtepi8_epi16() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi8(127,120,100,50,10,5,0,-5,-10,-20,-30,-40,-50,-60,-70,-80);
        let r = _mm_cvtepi8_epi16(a);
        let out: [i16;8] = std::mem::transmute::<__m128i, [i16;8]>(r);
        let _ = out;
        if get_fuzzing() { info!("Starting fuzzing"); for _ in 0..get_iterations() { let _ = _mm_cvtepi8_epi16(_mm_set1_epi8(get_random_i32_array::<4>()[0] as i8)); } }
    }
    Ok(())
}
