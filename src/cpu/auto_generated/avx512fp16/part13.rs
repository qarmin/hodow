use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_maskz_fnmadd_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_fnmadd_sh(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_fnmadd_sh(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fnmadd_round_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_fnmadd_round_sh::<0>(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fnmadd_round_sh::<0>(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fnmadd_round_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_fnmadd_round_sh::<0>(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fnmadd_round_sh::<0>(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fnmadd_round_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask3_fnmadd_round_sh::<0>(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */, create__mmask8_from(0b01010101));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask3_fnmadd_round_sh::<0>(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */, create_random__mmask8());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fnmadd_round_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_fnmadd_round_sh::<0>(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_fnmadd_round_sh::<0>(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fnmsub_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_fnmsub_ph(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fnmsub_ph(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fnmsub_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_fnmsub_ph(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fnmsub_ph(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fnmsub_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask3_fnmsub_ph(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */, create__mmask8_from(0b01010101));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask3_fnmsub_ph(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */, create_random__mmask8());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fnmsub_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_fnmsub_ph(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_fnmsub_ph(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_fnmsub_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_fnmsub_ph(0 /* __m256h */, 0 /* __m256h */, 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_fnmsub_ph(0 /* __m256h */, 0 /* __m256h */, 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_fnmsub_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_mask_fnmsub_ph(0 /* __m256h */, create__mmask16_from(0b0101010101010101), 0 /* __m256h */, 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_fnmsub_ph(0 /* __m256h */, create_random__mmask16(), 0 /* __m256h */, 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask3_fnmsub_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_mask3_fnmsub_ph(0 /* __m256h */, 0 /* __m256h */, 0 /* __m256h */, create__mmask16_from(0b0101010101010101));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask3_fnmsub_ph(0 /* __m256h */, 0 /* __m256h */, 0 /* __m256h */, create_random__mmask16());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_fnmsub_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_maskz_fnmsub_ph(create__mmask16_from(0b0101010101010101), 0 /* __m256h */, 0 /* __m256h */, 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_fnmsub_ph(create_random__mmask16(), 0 /* __m256h */, 0 /* __m256h */, 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_fnmsub_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_fnmsub_ph(0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_fnmsub_ph(0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_fnmsub_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_fnmsub_ph(0 /* __m512h */, create__mmask32_from(0x55555555u32), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_fnmsub_ph(0 /* __m512h */, create_random__mmask32(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask3_fnmsub_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask3_fnmsub_ph(0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */, create__mmask32_from(0x55555555u32));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask3_fnmsub_ph(0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */, create_random__mmask32());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_fnmsub_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_fnmsub_ph(create__mmask32_from(0x55555555u32), 0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_fnmsub_ph(create_random__mmask32(), 0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_fnmsub_round_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_fnmsub_round_ph::<0>(0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_fnmsub_round_ph::<0>(0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_fnmsub_round_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_fnmsub_round_ph::<0>(0 /* __m512h */, create__mmask32_from(0x55555555u32), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_fnmsub_round_ph::<0>(0 /* __m512h */, create_random__mmask32(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask3_fnmsub_round_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask3_fnmsub_round_ph::<0>(0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */, create__mmask32_from(0x55555555u32));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask3_fnmsub_round_ph::<0>(0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */, create_random__mmask32());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_fnmsub_round_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_fnmsub_round_ph::<0>(create__mmask32_from(0x55555555u32), 0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_fnmsub_round_ph::<0>(create_random__mmask32(), 0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fnmsub_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_fnmsub_sh(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fnmsub_sh(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fnmsub_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_fnmsub_sh(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fnmsub_sh(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fnmsub_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask3_fnmsub_sh(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */, create__mmask8_from(0b01010101));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask3_fnmsub_sh(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */, create_random__mmask8());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fnmsub_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_fnmsub_sh(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_fnmsub_sh(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fnmsub_round_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_fnmsub_round_sh::<0>(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fnmsub_round_sh::<0>(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fnmsub_round_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_fnmsub_round_sh::<0>(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fnmsub_round_sh::<0>(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fnmsub_round_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask3_fnmsub_round_sh::<0>(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */, create__mmask8_from(0b01010101));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask3_fnmsub_round_sh::<0>(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */, create_random__mmask8());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fnmsub_round_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_fnmsub_round_sh::<0>(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_fnmsub_round_sh::<0>(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fmaddsub_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_fmaddsub_ph(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fmaddsub_ph(0 /* __m128h */, 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}
