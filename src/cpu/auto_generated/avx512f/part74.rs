use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm256_mask_cvtusepi64_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtusepi64_storeu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i16; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_cvtusepi64_storeu_epi16(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtepi64_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_cvtepi64_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtepi64_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_mask_cvtepi64_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi64_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_cvtepi64_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtsepi64_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtsepi64_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsepi64_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_cvtsepi64_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtusepi64_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtusepi64_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtusepi64_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_cvtusepi64_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtepi64_storeu_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i32; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_cvtepi64_storeu_epi32(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtepi64_storeu_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i32; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_mask_cvtepi64_storeu_epi32(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi64_storeu_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i32; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_cvtepi64_storeu_epi32(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtsepi64_storeu_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i32; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_cvtsepi64_storeu_epi32(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtsepi64_storeu_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i32; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_mask_cvtsepi64_storeu_epi32(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsepi64_storeu_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i32; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_cvtsepi64_storeu_epi32(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtusepi64_storeu_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i32; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_cvtusepi64_storeu_epi32(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtusepi64_storeu_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i32; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_mask_cvtusepi64_storeu_epi32(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtusepi64_storeu_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i32; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_cvtusepi64_storeu_epi32(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm512_storeu_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i32; 1];
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_storeu_epi32(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm256_storeu_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i32; 1];
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_storeu_epi32(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_storeu_epi32() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i32; 1];
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_storeu_epi32(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm512_loadu_epi64() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1i64; 1];
        let result = unpack__m512i_to_i32_array(_mm512_loadu_epi64(ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm256_loadu_epi64() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1i64; 1];
        let result = unpack__m256i_to_i32_array(_mm256_loadu_epi64(ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm_loadu_epi64() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [1i64; 1];
        let result = unpack__m128i_to_i32_array(_mm_loadu_epi64(ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm512_storeu_epi64() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i64; 1];
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_storeu_epi64(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm256_storeu_epi64() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i64; 1];
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_storeu_epi64(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_storeu_epi64() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i64; 1];
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_storeu_epi64(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm512_loadu_si512() -> Result<(), String> {
    unsafe {
        let ptr_mem_addr = [create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]); 1];
        let result = unpack__m512i_to_i32_array(_mm512_loadu_si512(ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}
