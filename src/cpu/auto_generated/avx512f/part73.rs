use std::arch::x86_64::*;

use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm512_undefined_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_undefined_epi32());
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_undefined_epi32();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_undefined() -> Result<(), String> {
    unsafe {
        let result = unpack__m512_to_f32_array(_mm512_undefined());
        check_array_equality(&result, &[0.0f32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_undefined();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_loadu_epi32() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1i32; 1];
        let result = unpack__m512i_to_i32_array(_mm512_loadu_epi32(ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm256_loadu_epi32() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1i32; 1];
        let result = unpack__m256i_to_i32_array(_mm256_loadu_epi32(ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm_loadu_epi32() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1i32; 1];
        let result = unpack__m128i_to_i32_array(_mm_loadu_epi32(ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtepi32_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_cvtepi32_storeu_epi16(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtepi32_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_mask_cvtepi32_storeu_epi16(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi32_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_cvtepi32_storeu_epi16(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtsepi32_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtsepi32_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsepi32_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_cvtsepi32_storeu_epi16(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtusepi32_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtusepi32_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtusepi32_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_cvtusepi32_storeu_epi16(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtepi32_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_cvtepi32_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtepi32_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_mask_cvtepi32_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi32_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_cvtepi32_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtsepi32_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtsepi32_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsepi32_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_cvtsepi32_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtusepi32_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtusepi32_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtusepi32_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_cvtusepi32_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtepi64_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_cvtepi64_storeu_epi16(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtepi64_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_mask_cvtepi64_storeu_epi16(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi64_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_cvtepi64_storeu_epi16(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtsepi64_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtsepi64_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsepi64_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_cvtsepi64_storeu_epi16(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtusepi64_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}
