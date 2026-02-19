use std::arch::x86_64::*;

use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm512_mask_expandloadu_epi16() -> Result<(), String> {
    unsafe {
        let src = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = [1i16; 1];
        let result = unpack__m512i_to_i32_array(_mm512_mask_expandloadu_epi16(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_expandloadu_epi16() -> Result<(), String> {
    unsafe {
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = [1i16; 1];
        let result = unpack__m512i_to_i32_array(_mm512_maskz_expandloadu_epi16(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_expandloadu_epi16() -> Result<(), String> {
    unsafe {
        let src = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = [1i16; 1];
        let result = unpack__m256i_to_i32_array(_mm256_mask_expandloadu_epi16(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_expandloadu_epi16() -> Result<(), String> {
    unsafe {
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = [1i16; 1];
        let result = unpack__m256i_to_i32_array(_mm256_maskz_expandloadu_epi16(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_expandloadu_epi16() -> Result<(), String> {
    unsafe {
        let src = create__m128i_from_i32_array([1, 2, 3, 4]);
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1i16; 1];
        let result = unpack__m128i_to_i32_array(_mm_mask_expandloadu_epi16(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_maskz_expandloadu_epi16() -> Result<(), String> {
    unsafe {
        let k = create__mmask8_from(0b01010101);
        let ptr_mem_addr = [1i16; 1];
        let result = unpack__m128i_to_i32_array(_mm_maskz_expandloadu_epi16(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_expandloadu_epi8() -> Result<(), String> {
    unsafe {
        let src = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        let k = create__mmask64_from(0x5555555555555555u64);
        let ptr_mem_addr = [1i8; 1];
        let result = unpack__m512i_to_i32_array(_mm512_mask_expandloadu_epi8(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_expandloadu_epi8() -> Result<(), String> {
    unsafe {
        let k = create__mmask64_from(0x5555555555555555u64);
        let ptr_mem_addr = [1i8; 1];
        let result = unpack__m512i_to_i32_array(_mm512_maskz_expandloadu_epi8(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 16])?;
    }
    Ok(())
}

pub(super) fn test_mm256_mask_expandloadu_epi8() -> Result<(), String> {
    unsafe {
        let src = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = [1i8; 1];
        let result = unpack__m256i_to_i32_array(_mm256_mask_expandloadu_epi8(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_expandloadu_epi8() -> Result<(), String> {
    unsafe {
        let k = create__mmask32_from(0x55555555u32);
        let ptr_mem_addr = [1i8; 1];
        let result = unpack__m256i_to_i32_array(_mm256_maskz_expandloadu_epi8(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm_mask_expandloadu_epi8() -> Result<(), String> {
    unsafe {
        let src = create__m128i_from_i32_array([1, 2, 3, 4]);
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = [1i8; 1];
        let result = unpack__m128i_to_i32_array(_mm_mask_expandloadu_epi8(src, k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_maskz_expandloadu_epi8() -> Result<(), String> {
    unsafe {
        let k = create__mmask16_from(0b0101010101010101);
        let ptr_mem_addr = [1i8; 1];
        let result = unpack__m128i_to_i32_array(_mm_maskz_expandloadu_epi8(k, ptr_mem_addr.as_ptr()));
        check_array_equality(&result, &[0i32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm512_mask_compressstoreu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_base_addr = [1i16; 1];
        let k = create__mmask32_from(0x55555555u32);
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_compressstoreu_epi16(ptr_base_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_compressstoreu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_base_addr = [1i16; 1];
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_mask_compressstoreu_epi16(ptr_base_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_compressstoreu_epi16() -> Result<(), String> {
    unsafe {
        let mut ptr_base_addr = [1i16; 1];
        let k = create__mmask8_from(0b01010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_compressstoreu_epi16(ptr_base_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_compressstoreu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_base_addr = [1i8; 1];
        let k = create__mmask64_from(0x5555555555555555u64);
        let a = create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]);
        _mm512_mask_compressstoreu_epi8(ptr_base_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm256_mask_compressstoreu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_base_addr = [1i8; 1];
        let k = create__mmask32_from(0x55555555u32);
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_mask_compressstoreu_epi8(ptr_base_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm_mask_compressstoreu_epi8() -> Result<(), String> {
    unsafe {
        let mut ptr_base_addr = [1i8; 1];
        let k = create__mmask16_from(0b0101010101010101);
        let a = create__m128i_from_i32_array([1, 2, 3, 4]);
        _mm_mask_compressstoreu_epi8(ptr_base_addr.as_mut_ptr(), k, a);
    }
    Ok(())
}

pub(super) fn test_mm512_mask_compress_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_compress_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_compress_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_compress_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_compress_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_compress_epi16(create_random__mmask32(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_compress_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_compress_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_compress_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_compress_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_compress_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_compress_epi16(create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_compress_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_compress_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_compress_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_compress_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_compress_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_compress_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_compress_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_compress_epi8(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_compress_epi8(create_random__m512i(), create_random__mmask64(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_compress_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_compress_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_compress_epi8(create_random__mmask64(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_compress_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_compress_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_compress_epi8(create_random__m256i(), create_random__mmask32(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_compress_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_compress_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_compress_epi8(create_random__mmask32(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_compress_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_compress_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_compress_epi8(create_random__m128i(), create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_compress_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_compress_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_compress_epi8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}
