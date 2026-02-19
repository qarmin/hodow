use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_cvtepu16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtepu16_ph(create__m128i_from_i32_array([1, 2, 3, 4]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtepu16_ph(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepu16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_cvtepu16_ph(0 /* __m128h */, create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvtepu16_ph(0 /* __m128h */, create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepu16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_cvtepu16_ph(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvtepu16_ph(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvtepu16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_cvtepu16_ph(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_cvtepu16_ph(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtepu16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_mask_cvtepu16_ph(0 /* __m256h */, create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_cvtepu16_ph(0 /* __m256h */, create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvtepu16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_maskz_cvtepu16_ph(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_cvtepu16_ph(create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtepu16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_cvtepu16_ph(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvtepu16_ph(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtepu16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_cvtepu16_ph(0 /* __m512h */, create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvtepu16_ph(0 /* __m512h */, create_random__mmask32(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtepu16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_cvtepu16_ph(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvtepu16_ph(create_random__mmask32(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvt_roundepu16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_cvt_roundepu16_ph::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvt_roundepu16_ph::<0>(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvt_roundepu16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_cvt_roundepu16_ph::<0>(0 /* __m512h */, create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvt_roundepu16_ph::<0>(0 /* __m512h */, create_random__mmask32(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvt_roundepu16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_cvt_roundepu16_ph::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvt_roundepu16_ph::<0>(create_random__mmask32(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtepi32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtepi32_ph(create__m128i_from_i32_array([1, 2, 3, 4]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtepi32_ph(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_cvtepi32_ph(0 /* __m128h */, create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvtepi32_ph(0 /* __m128h */, create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_cvtepi32_ph(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvtepi32_ph(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvtepi32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_cvtepi32_ph(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_cvtepi32_ph(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtepi32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_mask_cvtepi32_ph(0 /* __m128h */, create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_cvtepi32_ph(0 /* __m128h */, create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvtepi32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_maskz_cvtepi32_ph(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_cvtepi32_ph(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtepi32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_cvtepi32_ph(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvtepi32_ph(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtepi32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_cvtepi32_ph(0 /* __m256h */, create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvtepi32_ph(0 /* __m256h */, create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtepi32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_cvtepi32_ph(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvtepi32_ph(create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvt_roundepi32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_cvt_roundepi32_ph::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvt_roundepi32_ph::<0>(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvt_roundepi32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_cvt_roundepi32_ph::<0>(0 /* __m256h */, create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvt_roundepi32_ph::<0>(0 /* __m256h */, create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvt_roundepi32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_cvt_roundepi32_ph::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvt_roundepi32_ph::<0>(create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvti32_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvti32_sh(0 /* __m128h */, 1i32);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvti32_sh(0 /* __m128h */, rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundi32_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvt_roundi32_sh::<0>(0 /* __m128h */, 1i32);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundi32_sh::<0>(0 /* __m128h */, rand::random::<i32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtepu32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtepu32_ph(create__m128i_from_i32_array([1, 2, 3, 4]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtepu32_ph(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepu32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_cvtepu32_ph(0 /* __m128h */, create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvtepu32_ph(0 /* __m128h */, create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepu32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_cvtepu32_ph(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvtepu32_ph(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvtepu32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_cvtepu32_ph(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_cvtepu32_ph(create_random__m256i());
            }
        }
    }
    Ok(())
}
