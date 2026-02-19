use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm512_maskz_cvtph_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtph_epu16(create__mmask32_from(0x55555555u32), 0 /* __m512h */));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvtph_epu16(create_random__mmask32(), 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvt_roundph_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvt_roundph_epu16::<0>(0 /* __m512h */));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvt_roundph_epu16::<0>(0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvt_roundph_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvt_roundph_epu16::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), 0 /* __m512h */));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvt_roundph_epu16::<0>(create_random__m512i(), create_random__mmask32(), 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvt_roundph_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvt_roundph_epu16::<0>(create__mmask32_from(0x55555555u32), 0 /* __m512h */));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvt_roundph_epu16::<0>(create_random__mmask32(), 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttph_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvttph_epi16(0 /* __m128h */));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvttph_epi16(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvttph_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvttph_epi16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), 0 /* __m128h */));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvttph_epi16(create_random__m128i(), create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvttph_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvttph_epi16(create__mmask8_from(0b01010101), 0 /* __m128h */));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvttph_epi16(create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvttph_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvttph_epi16(0 /* __m256h */));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_cvttph_epi16(0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvttph_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvttph_epi16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), 0 /* __m256h */));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_cvttph_epi16(create_random__m256i(), create_random__mmask16(), 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvttph_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_cvttph_epi16(create__mmask16_from(0b0101010101010101), 0 /* __m256h */));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_cvttph_epi16(create_random__mmask16(), 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvttph_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvttph_epi16(0 /* __m512h */));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvttph_epi16(0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvttph_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvttph_epi16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), 0 /* __m512h */));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvttph_epi16(create_random__m512i(), create_random__mmask32(), 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvttph_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvttph_epi16(create__mmask32_from(0x55555555u32), 0 /* __m512h */));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvttph_epi16(create_random__mmask32(), 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtt_roundph_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvtt_roundph_epi16::<0>(0 /* __m512h */));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvtt_roundph_epi16::<0>(0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtt_roundph_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtt_roundph_epi16::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), 0 /* __m512h */));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvtt_roundph_epi16::<0>(create_random__m512i(), create_random__mmask32(), 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtt_roundph_epi16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtt_roundph_epi16::<0>(create__mmask32_from(0x55555555u32), 0 /* __m512h */));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvtt_roundph_epi16::<0>(create_random__mmask32(), 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttph_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvttph_epu16(0 /* __m128h */));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvttph_epu16(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvttph_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvttph_epu16(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), 0 /* __m128h */));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvttph_epu16(create_random__m128i(), create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvttph_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_maskz_cvttph_epu16(create__mmask8_from(0b01010101), 0 /* __m128h */));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvttph_epu16(create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvttph_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_cvttph_epu16(0 /* __m256h */));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_cvttph_epu16(0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvttph_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_mask_cvttph_epu16(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask16_from(0b0101010101010101), 0 /* __m256h */));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_cvttph_epu16(create_random__m256i(), create_random__mmask16(), 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvttph_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_maskz_cvttph_epu16(create__mmask16_from(0b0101010101010101), 0 /* __m256h */));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_cvttph_epu16(create_random__mmask16(), 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvttph_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvttph_epu16(0 /* __m512h */));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvttph_epu16(0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvttph_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvttph_epu16(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), 0 /* __m512h */));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvttph_epu16(create_random__m512i(), create_random__mmask32(), 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvttph_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvttph_epu16(create__mmask32_from(0x55555555u32), 0 /* __m512h */));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvttph_epu16(create_random__mmask32(), 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtt_roundph_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_cvtt_roundph_epu16::<0>(0 /* __m512h */));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvtt_roundph_epu16::<0>(0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtt_roundph_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_mask_cvtt_roundph_epu16::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), create__mmask32_from(0x55555555u32), 0 /* __m512h */));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvtt_roundph_epu16::<0>(create_random__m512i(), create_random__mmask32(), 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtt_roundph_epu16() -> Result<(), String> {
    unsafe {
        let result = unpack__m512i_to_i32_array(_mm512_maskz_cvtt_roundph_epu16::<0>(create__mmask32_from(0x55555555u32), 0 /* __m512h */));
        check_array_equality(&result, &[0i32; 16])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvtt_roundph_epu16::<0>(create_random__mmask32(), 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtph_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_cvtph_epi32(0 /* __m128h */));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtph_epi32(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtph_epi32() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_mask_cvtph_epi32(create__m128i_from_i32_array([1, 2, 3, 4]), create__mmask8_from(0b01010101), 0 /* __m128h */));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvtph_epi32(create_random__m128i(), create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}
