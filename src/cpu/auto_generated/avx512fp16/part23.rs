use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm256_mask_cvtepu32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_mask_cvtepu32_ph(0 /* __m128h */, create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_cvtepu32_ph(0 /* __m128h */, create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvtepu32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_maskz_cvtepu32_ph(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_cvtepu32_ph(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtepu32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_cvtepu32_ph(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvtepu32_ph(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtepu32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_cvtepu32_ph(0 /* __m256h */, create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvtepu32_ph(0 /* __m256h */, create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtepu32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_cvtepu32_ph(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvtepu32_ph(create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvt_roundepu32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_cvt_roundepu32_ph::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvt_roundepu32_ph::<0>(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvt_roundepu32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_cvt_roundepu32_ph::<0>(0 /* __m256h */, create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvt_roundepu32_ph::<0>(0 /* __m256h */, create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvt_roundepu32_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_cvt_roundepu32_ph::<0>(create__mmask16_from(0b0101010101010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvt_roundepu32_ph::<0>(create_random__mmask16(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtu32_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtu32_sh(0 /* __m128h */, 1u32);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtu32_sh(0 /* __m128h */, rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundu32_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvt_roundu32_sh::<0>(0 /* __m128h */, 1u32);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundu32_sh::<0>(0 /* __m128h */, rand::random::<u32>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtepi64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtepi64_ph(create__m128i_from_i32_array([1, 2, 3, 4]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtepi64_ph(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_cvtepi64_ph(0 /* __m128h */, create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvtepi64_ph(0 /* __m128h */, create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_cvtepi64_ph(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvtepi64_ph(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvtepi64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_cvtepi64_ph(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_cvtepi64_ph(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtepi64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_mask_cvtepi64_ph(0 /* __m128h */, create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_cvtepi64_ph(0 /* __m128h */, create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvtepi64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_maskz_cvtepi64_ph(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_cvtepi64_ph(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtepi64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_cvtepi64_ph(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvtepi64_ph(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtepi64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_cvtepi64_ph(0 /* __m128h */, create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvtepi64_ph(0 /* __m128h */, create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtepi64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_cvtepi64_ph(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvtepi64_ph(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvt_roundepi64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_cvt_roundepi64_ph::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvt_roundepi64_ph::<0>(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvt_roundepi64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_cvt_roundepi64_ph::<0>(0 /* __m128h */, create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvt_roundepi64_ph::<0>(0 /* __m128h */, create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvt_roundepi64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_cvt_roundepi64_ph::<0>(create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvt_roundepi64_ph::<0>(create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtepu64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtepu64_ph(create__m128i_from_i32_array([1, 2, 3, 4]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtepu64_ph(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepu64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_cvtepu64_ph(0 /* __m128h */, create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvtepu64_ph(0 /* __m128h */, create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepu64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_cvtepu64_ph(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvtepu64_ph(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvtepu64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_cvtepu64_ph(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_cvtepu64_ph(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtepu64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_mask_cvtepu64_ph(0 /* __m128h */, create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_cvtepu64_ph(0 /* __m128h */, create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvtepu64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_maskz_cvtepu64_ph(create__mmask8_from(0b01010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_cvtepu64_ph(create_random__mmask8(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtepu64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_cvtepu64_ph(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvtepu64_ph(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtepu64_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_cvtepu64_ph(0 /* __m128h */, create__mmask8_from(0b01010101), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvtepu64_ph(0 /* __m128h */, create_random__mmask8(), create_random__m512i());
            }
        }
    }
    Ok(())
}
