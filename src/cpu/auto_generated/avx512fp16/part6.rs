use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm512_mask_div_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_div_ph(0 /* __m512h */, create__mmask32_from(0x55555555u32), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_div_ph(0 /* __m512h */, create_random__mmask32(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_div_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_div_ph(create__mmask32_from(0x55555555u32), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_div_ph(create_random__mmask32(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_div_round_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_div_round_ph::<0>(0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_div_round_ph::<0>(0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_div_round_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_div_round_ph::<0>(0 /* __m512h */, create__mmask32_from(0x55555555u32), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_div_round_ph::<0>(0 /* __m512h */, create_random__mmask32(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_div_round_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_div_round_ph::<0>(create__mmask32_from(0x55555555u32), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_div_round_ph::<0>(create_random__mmask32(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_div_round_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_div_round_sh::<0>(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_div_round_sh::<0>(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_div_round_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_div_round_sh::<0>(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_div_round_sh::<0>(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_div_round_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_div_round_sh::<0>(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_div_round_sh::<0>(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_div_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_div_sh(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_div_sh(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_div_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_div_sh(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_div_sh(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_div_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_div_sh(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_div_sh(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm_mul_pch(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mul_pch(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_mul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_mul_pch(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_mul_pch(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_mul_pch(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_mul_pch(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm256_mul_pch(0 /* __m256h */, 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mul_pch(0 /* __m256h */, 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_mul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm256_mask_mul_pch(0 /* __m256h */, create__mmask8_from(0b01010101), 0 /* __m256h */, 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_mul_pch(0 /* __m256h */, create_random__mmask8(), 0 /* __m256h */, 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_mul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm256_maskz_mul_pch(create__mmask8_from(0b01010101), 0 /* __m256h */, 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_mul_pch(create_random__mmask8(), 0 /* __m256h */, 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mul_pch(0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mul_pch(0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_mul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_mul_pch(0 /* __m512h */, create__mmask16_from(0b0101010101010101), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_mul_pch(0 /* __m512h */, create_random__mmask16(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_mul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_mul_pch(create__mmask16_from(0b0101010101010101), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_mul_pch(create_random__mmask16(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mul_round_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mul_round_pch::<0>(0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mul_round_pch::<0>(0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_mul_round_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_mul_round_pch::<0>(0 /* __m512h */, create__mmask16_from(0b0101010101010101), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_mul_round_pch::<0>(0 /* __m512h */, create_random__mmask16(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_mul_round_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_mul_round_pch::<0>(create__mmask16_from(0b0101010101010101), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_mul_round_pch::<0>(create_random__mmask16(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mul_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_mul_sch(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mul_sch(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_mul_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_mul_sch(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_mul_sch(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mul_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_mul_sch(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_mul_sch(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mul_round_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_mul_round_sch::<0>(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mul_round_sch::<0>(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_mul_round_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_mul_round_sch::<0>(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_mul_round_sch::<0>(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_mul_round_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_mul_round_sch::<0>(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_mul_round_sch::<0>(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm_fmul_pch(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fmul_pch(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}
