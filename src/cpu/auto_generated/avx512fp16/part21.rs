use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm512_reduce_max_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_reduce_max_ph(0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_reduce_max_ph(0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fpclass_ph_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_fpclass_ph_mask::<0>(0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fpclass_ph_mask::<0>(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fpclass_ph_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_fpclass_ph_mask::<0>(create__mmask8_from(0b01010101), 0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fpclass_ph_mask::<0>(create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_fpclass_ph_mask() -> Result<(), String> {
    unsafe {
        let result = _mm256_fpclass_ph_mask::<0>(0 /* __m256h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_fpclass_ph_mask::<0>(0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_fpclass_ph_mask() -> Result<(), String> {
    unsafe {
        let result = _mm256_mask_fpclass_ph_mask::<0>(create__mmask16_from(0b0101010101010101), 0 /* __m256h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_fpclass_ph_mask::<0>(create_random__mmask16(), 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_fpclass_ph_mask() -> Result<(), String> {
    unsafe {
        let result = _mm512_fpclass_ph_mask::<0>(0 /* __m512h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_fpclass_ph_mask::<0>(0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_fpclass_ph_mask() -> Result<(), String> {
    unsafe {
        let result = _mm512_mask_fpclass_ph_mask::<0>(create__mmask32_from(0x55555555u32), 0 /* __m512h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_fpclass_ph_mask::<0>(create_random__mmask32(), 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fpclass_sh_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_fpclass_sh_mask::<0>(0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fpclass_sh_mask::<0>(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fpclass_sh_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_fpclass_sh_mask::<0>(create__mmask8_from(0b01010101), 0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fpclass_sh_mask::<0>(create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_blend_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_blend_ph(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_blend_ph(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_blend_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_mask_blend_ph(create__mmask16_from(0b0101010101010101), 0 /* __m256h */, 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_blend_ph(create_random__mmask16(), 0 /* __m256h */, 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_blend_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_blend_ph(create__mmask32_from(0x55555555u32), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_blend_ph(create_random__mmask32(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_permutex2var_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_permutex2var_ph(0 /* __m128h */, create__m128i_from_i32_array([1, 2, 3, 4]), 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_permutex2var_ph(0 /* __m128h */, create_random__m128i(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_permutex2var_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_permutex2var_ph(0 /* __m256h */, create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_permutex2var_ph(0 /* __m256h */, create_random__m256i(), 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_permutex2var_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_permutex2var_ph(0 /* __m512h */, create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_permutex2var_ph(0 /* __m512h */, create_random__m512i(), 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_permutexvar_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_permutexvar_ph(create__m128i_from_i32_array([1, 2, 3, 4]), 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_permutexvar_ph(create_random__m128i(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_permutexvar_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_permutexvar_ph(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_permutexvar_ph(create_random__m256i(), 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_permutexvar_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_permutexvar_ph(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]), 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_permutexvar_ph(create_random__m512i(), 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtepi16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtepi16_ph(create__m128i_from_i32_array([1, 2, 3, 4]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtepi16_ph(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtepi16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_cvtepi16_ph(0 /* __m128h */, create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvtepi16_ph(0 /* __m128h */, create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtepi16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_cvtepi16_ph(create__mmask8_from(0b01010101), create__m128i_from_i32_array([1, 2, 3, 4]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvtepi16_ph(create_random__mmask8(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvtepi16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_cvtepi16_ph(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_cvtepi16_ph(create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cvtepi16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_mask_cvtepi16_ph(0 /* __m256h */, create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_cvtepi16_ph(0 /* __m256h */, create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cvtepi16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_maskz_cvtepi16_ph(create__mmask16_from(0b0101010101010101), create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_cvtepi16_ph(create_random__mmask16(), create_random__m256i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvtepi16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_cvtepi16_ph(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvtepi16_ph(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvtepi16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_cvtepi16_ph(0 /* __m512h */, create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvtepi16_ph(0 /* __m512h */, create_random__mmask32(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvtepi16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_cvtepi16_ph(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvtepi16_ph(create_random__mmask32(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cvt_roundepi16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_cvt_roundepi16_ph::<0>(create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cvt_roundepi16_ph::<0>(create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cvt_roundepi16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_cvt_roundepi16_ph::<0>(0 /* __m512h */, create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cvt_roundepi16_ph::<0>(0 /* __m512h */, create_random__mmask32(), create_random__m512i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cvt_roundepi16_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_cvt_roundepi16_ph::<0>(create__mmask32_from(0x55555555u32), create__m512i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cvt_roundepi16_ph::<0>(create_random__mmask32(), create_random__m512i());
            }
        }
    }
    Ok(())
}
