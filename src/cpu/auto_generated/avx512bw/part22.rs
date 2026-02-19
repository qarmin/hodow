use std::arch::x86_64::*;

use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_maskz_unpacklo_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_unpacklo_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_unpacklo_epi16(create_random__mmask8(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_unpacklo_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_unpacklo_epi8(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_unpacklo_epi8(create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_unpacklo_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_unpacklo_epi8(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_unpacklo_epi8(create_random__m512i(), create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_unpacklo_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_unpacklo_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_unpacklo_epi8(create_random__mmask64(), create_random__m512i(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_unpacklo_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_unpacklo_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_unpacklo_epi8(create_random__m256i(), create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_unpacklo_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_unpacklo_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_unpacklo_epi8(create_random__mmask32(), create_random__m256i(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_unpacklo_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_unpacklo_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_unpacklo_epi8(create_random__m128i(), create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_unpacklo_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_unpacklo_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_unpacklo_epi8(create_random__mmask16(), create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_mov_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_mov_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_mov_epi16(create_random__m512i(), create_random__mmask32(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_mov_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_mov_epi16(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_mov_epi16(create_random__mmask32(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_mov_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_mov_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_mov_epi16(create_random__m256i(), create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_mov_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_mov_epi16(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_mov_epi16(create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_mov_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_mov_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_mov_epi16(create_random__m128i(), create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mov_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_mov_epi16(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_mov_epi16(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_mov_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_mov_epi8(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_mov_epi8(create_random__m512i(), create_random__mmask64(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_mov_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_mov_epi8(create__mmask64_from(0x5555555555555555u64), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16])));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_mov_epi8(create_random__mmask64(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_mov_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_mov_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_mov_epi8(create_random__m256i(), create_random__mmask32(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_mov_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_mov_epi8(create__mmask32_from(0x55555555u32), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_mov_epi8(create_random__mmask32(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_mov_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_mov_epi8(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_mov_epi8(create_random__m128i(), create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mov_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_mov_epi8(create__mmask16_from(0b0101010101010101), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_mov_epi8(create_random__mmask16(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_set1_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_set1_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), 1i16));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_set1_epi16(create_random__m512i(), create_random__mmask32(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_set1_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_set1_epi16(create__mmask32_from(0x55555555u32), 1i16));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_set1_epi16(create_random__mmask32(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_set1_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_set1_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), 1i16));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_set1_epi16(create_random__m256i(), create_random__mmask16(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_set1_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_set1_epi16(create__mmask16_from(0b0101010101010101), 1i16));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_set1_epi16(create_random__mmask16(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_set1_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_set1_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), 1i16));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_set1_epi16(create_random__m128i(), create_random__mmask8(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_set1_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_set1_epi16(create__mmask8_from(0b01010101), 1i16));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_set1_epi16(create_random__mmask8(), rand::random::<i16>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_set1_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_set1_epi8(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask64_from(0x5555555555555555u64), 1i8));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_set1_epi8(create_random__m512i(), create_random__mmask64(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_set1_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_set1_epi8(create__mmask64_from(0x5555555555555555u64), 1i8));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_set1_epi8(create_random__mmask64(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_set1_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_set1_epi8(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask32_from(0x55555555u32), 1i8));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_set1_epi8(create_random__m256i(), create_random__mmask32(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_set1_epi8() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_set1_epi8(create__mmask32_from(0x55555555u32), 1i8));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_set1_epi8(create_random__mmask32(), rand::random::<i8>());
            }
        }
    }
    Ok(())
}
