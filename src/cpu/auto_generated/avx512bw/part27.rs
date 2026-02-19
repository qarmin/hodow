use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_maskz_alignr_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_alignr_epi8::<0>(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_alignr_epi8::<0>(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtsepi16_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask32_from(0x55555555u32);
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtsepi16_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsepi16_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_cvtsepi16_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtepi16_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask32_from(0x55555555u32);
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_cvtepi16_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtepi16_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_mask_cvtepi16_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi16_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_cvtepi16_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtusepi16_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask32_from(0x55555555u32);
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtusepi16_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtusepi16_storeu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1i8; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_cvtusepi16_storeu_epi8(ptr_mem_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}
