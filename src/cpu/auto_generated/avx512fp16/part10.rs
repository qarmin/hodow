use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_mask_fcmadd_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_fcmadd_pch(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fcmadd_pch(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fcmadd_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask3_fcmadd_pch(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */, create__mmask8_from(0b01010101));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask3_fcmadd_pch(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */, create_random__mmask8());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fcmadd_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_fcmadd_pch(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_fcmadd_pch(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_fcmadd_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm256_fcmadd_pch(0 /* __m256h */, 0 /* __m256h */, 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_fcmadd_pch(0 /* __m256h */, 0 /* __m256h */, 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_fcmadd_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm256_mask_fcmadd_pch(0 /* __m256h */, create__mmask8_from(0b01010101), 0 /* __m256h */, 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_fcmadd_pch(0 /* __m256h */, create_random__mmask8(), 0 /* __m256h */, 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask3_fcmadd_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm256_mask3_fcmadd_pch(0 /* __m256h */, 0 /* __m256h */, 0 /* __m256h */, create__mmask8_from(0b01010101));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask3_fcmadd_pch(0 /* __m256h */, 0 /* __m256h */, 0 /* __m256h */, create_random__mmask8());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_fcmadd_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm256_maskz_fcmadd_pch(create__mmask8_from(0b01010101), 0 /* __m256h */, 0 /* __m256h */, 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_fcmadd_pch(create_random__mmask8(), 0 /* __m256h */, 0 /* __m256h */, 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_fcmadd_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_fcmadd_pch(0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_fcmadd_pch(0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_fcmadd_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_fcmadd_pch(0 /* __m512h */, create__mmask16_from(0b0101010101010101), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_fcmadd_pch(0 /* __m512h */, create_random__mmask16(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask3_fcmadd_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask3_fcmadd_pch(0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */, create__mmask16_from(0b0101010101010101));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask3_fcmadd_pch(0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */, create_random__mmask16());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_fcmadd_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_fcmadd_pch(create__mmask16_from(0b0101010101010101), 0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_fcmadd_pch(create_random__mmask16(), 0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_fcmadd_round_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_fcmadd_round_pch::<0>(0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_fcmadd_round_pch::<0>(0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_fcmadd_round_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_fcmadd_round_pch::<0>(0 /* __m512h */, create__mmask16_from(0b0101010101010101), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_fcmadd_round_pch::<0>(0 /* __m512h */, create_random__mmask16(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask3_fcmadd_round_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask3_fcmadd_round_pch::<0>(0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */, create__mmask16_from(0b0101010101010101));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask3_fcmadd_round_pch::<0>(0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */, create_random__mmask16());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_fcmadd_round_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_fcmadd_round_pch::<0>(create__mmask16_from(0b0101010101010101), 0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_fcmadd_round_pch::<0>(create_random__mmask16(), 0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fcmadd_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_fcmadd_sch(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fcmadd_sch(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fcmadd_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_fcmadd_sch(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fcmadd_sch(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fcmadd_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask3_fcmadd_sch(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */, create__mmask8_from(0b01010101));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask3_fcmadd_sch(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */, create_random__mmask8());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fcmadd_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_fcmadd_sch(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_fcmadd_sch(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fcmadd_round_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_fcmadd_round_sch::<0>(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fcmadd_round_sch::<0>(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fcmadd_round_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_fcmadd_round_sch::<0>(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fcmadd_round_sch::<0>(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fcmadd_round_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask3_fcmadd_round_sch::<0>(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */, create__mmask8_from(0b01010101));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask3_fcmadd_round_sch::<0>(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */, create_random__mmask8());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fcmadd_round_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_fcmadd_round_sch::<0>(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_fcmadd_round_sch::<0>(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fmadd_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_fmadd_ph(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fmadd_ph(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fmadd_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_fmadd_ph(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fmadd_ph(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fmadd_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask3_fmadd_ph(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */, create__mmask8_from(0b01010101));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask3_fmadd_ph(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */, create_random__mmask8());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fmadd_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_fmadd_ph(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_fmadd_ph(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_fmadd_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_fmadd_ph(0 /* __m256h */, 0 /* __m256h */, 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_fmadd_ph(0 /* __m256h */, 0 /* __m256h */, 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_fmadd_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_mask_fmadd_ph(0 /* __m256h */, create__mmask16_from(0b0101010101010101), 0 /* __m256h */, 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_fmadd_ph(0 /* __m256h */, create_random__mmask16(), 0 /* __m256h */, 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask3_fmadd_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_mask3_fmadd_ph(0 /* __m256h */, 0 /* __m256h */, 0 /* __m256h */, create__mmask16_from(0b0101010101010101));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask3_fmadd_ph(0 /* __m256h */, 0 /* __m256h */, 0 /* __m256h */, create_random__mmask16());
            }
        }
    }
    Ok(())
}
