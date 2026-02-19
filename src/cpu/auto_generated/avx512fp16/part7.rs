use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_mask_fmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_fmul_pch(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fmul_pch(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_fmul_pch(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_fmul_pch(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_fmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm256_fmul_pch(0 /* __m256h */, 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_fmul_pch(0 /* __m256h */, 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_fmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm256_mask_fmul_pch(0 /* __m256h */, create__mmask8_from(0b01010101), 0 /* __m256h */, 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_fmul_pch(0 /* __m256h */, create_random__mmask8(), 0 /* __m256h */, 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_fmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm256_maskz_fmul_pch(create__mmask8_from(0b01010101), 0 /* __m256h */, 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_fmul_pch(create_random__mmask8(), 0 /* __m256h */, 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_fmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_fmul_pch(0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_fmul_pch(0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_fmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_fmul_pch(0 /* __m512h */, create__mmask16_from(0b0101010101010101), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_fmul_pch(0 /* __m512h */, create_random__mmask16(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_fmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_fmul_pch(create__mmask16_from(0b0101010101010101), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_fmul_pch(create_random__mmask16(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_fmul_round_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_fmul_round_pch::<0>(0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_fmul_round_pch::<0>(0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_fmul_round_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_fmul_round_pch::<0>(0 /* __m512h */, create__mmask16_from(0b0101010101010101), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_fmul_round_pch::<0>(0 /* __m512h */, create_random__mmask16(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_fmul_round_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_fmul_round_pch::<0>(create__mmask16_from(0b0101010101010101), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_fmul_round_pch::<0>(create_random__mmask16(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fmul_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_fmul_sch(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fmul_sch(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fmul_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_fmul_sch(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fmul_sch(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fmul_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_fmul_sch(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_fmul_sch(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fmul_round_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_fmul_round_sch::<0>(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fmul_round_sch::<0>(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fmul_round_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_fmul_round_sch::<0>(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fmul_round_sch::<0>(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fmul_round_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_fmul_round_sch::<0>(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_fmul_round_sch::<0>(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm_cmul_pch(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmul_pch(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_cmul_pch(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cmul_pch(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_cmul_pch(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cmul_pch(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm256_cmul_pch(0 /* __m256h */, 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_cmul_pch(0 /* __m256h */, 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_cmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm256_mask_cmul_pch(0 /* __m256h */, create__mmask8_from(0b01010101), 0 /* __m256h */, 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_cmul_pch(0 /* __m256h */, create_random__mmask8(), 0 /* __m256h */, 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_cmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm256_maskz_cmul_pch(create__mmask8_from(0b01010101), 0 /* __m256h */, 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_cmul_pch(create_random__mmask8(), 0 /* __m256h */, 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_cmul_pch(0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cmul_pch(0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_cmul_pch(0 /* __m512h */, create__mmask16_from(0b0101010101010101), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cmul_pch(0 /* __m512h */, create_random__mmask16(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_cmul_pch(create__mmask16_from(0b0101010101010101), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cmul_pch(create_random__mmask16(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_cmul_round_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_cmul_round_pch::<0>(0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_cmul_round_pch::<0>(0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_cmul_round_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_cmul_round_pch::<0>(0 /* __m512h */, create__mmask16_from(0b0101010101010101), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_cmul_round_pch::<0>(0 /* __m512h */, create_random__mmask16(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_cmul_round_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_cmul_round_pch::<0>(create__mmask16_from(0b0101010101010101), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_cmul_round_pch::<0>(create_random__mmask16(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmul_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_cmul_sch(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmul_sch(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}
