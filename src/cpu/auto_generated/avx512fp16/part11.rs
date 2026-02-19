use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

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

pub(super) fn test_mm_cvtxps_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtxps_ph(create__m128_from([1.0, 2.0, 3.0, 4.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtxps_ph(create_random__m128());
            }
        }
    }
    Ok(())
}
