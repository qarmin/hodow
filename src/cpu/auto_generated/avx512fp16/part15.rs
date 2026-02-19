use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm512_maskz_fmsubadd_round_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_fmsubadd_round_ph::<0>(create__mmask32_from(0x55555555u32), 0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_fmsubadd_round_ph::<0>(create_random__mmask32(), 0 /* __m512h */, 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_rcp_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_rcp_ph(0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_rcp_ph(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_rcp_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_rcp_ph(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_rcp_ph(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_rcp_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_rcp_ph(create__mmask8_from(0b01010101), 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_rcp_ph(create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_rcp_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_rcp_ph(0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_rcp_ph(0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_rcp_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_mask_rcp_ph(0 /* __m256h */, create__mmask16_from(0b0101010101010101), 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_rcp_ph(0 /* __m256h */, create_random__mmask16(), 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_rcp_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_maskz_rcp_ph(create__mmask16_from(0b0101010101010101), 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_rcp_ph(create_random__mmask16(), 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_rcp_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_rcp_ph(0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_rcp_ph(0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_rcp_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_rcp_ph(0 /* __m512h */, create__mmask32_from(0x55555555u32), 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_rcp_ph(0 /* __m512h */, create_random__mmask32(), 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_rcp_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_rcp_ph(create__mmask32_from(0x55555555u32), 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_rcp_ph(create_random__mmask32(), 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_rcp_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_rcp_sh(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_rcp_sh(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_rcp_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_rcp_sh(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_rcp_sh(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_rcp_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_rcp_sh(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_rcp_sh(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_rsqrt_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_rsqrt_ph(0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_rsqrt_ph(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_rsqrt_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_rsqrt_ph(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_rsqrt_ph(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_rsqrt_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_rsqrt_ph(create__mmask8_from(0b01010101), 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_rsqrt_ph(create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_rsqrt_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_rsqrt_ph(0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_rsqrt_ph(0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_rsqrt_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_mask_rsqrt_ph(0 /* __m256h */, create__mmask16_from(0b0101010101010101), 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_rsqrt_ph(0 /* __m256h */, create_random__mmask16(), 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_rsqrt_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_maskz_rsqrt_ph(create__mmask16_from(0b0101010101010101), 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_rsqrt_ph(create_random__mmask16(), 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_rsqrt_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_rsqrt_ph(0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_rsqrt_ph(0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_rsqrt_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_rsqrt_ph(0 /* __m512h */, create__mmask32_from(0x55555555u32), 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_rsqrt_ph(0 /* __m512h */, create_random__mmask32(), 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_rsqrt_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_rsqrt_ph(create__mmask32_from(0x55555555u32), 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_rsqrt_ph(create_random__mmask32(), 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_rsqrt_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_rsqrt_sh(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_rsqrt_sh(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_rsqrt_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_rsqrt_sh(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_rsqrt_sh(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_rsqrt_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_rsqrt_sh(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_rsqrt_sh(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sqrt_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_sqrt_ph(0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_sqrt_ph(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_sqrt_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_sqrt_ph(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_sqrt_ph(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_sqrt_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_sqrt_ph(create__mmask8_from(0b01010101), 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_sqrt_ph(create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_sqrt_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_sqrt_ph(0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_sqrt_ph(0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_sqrt_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_mask_sqrt_ph(0 /* __m256h */, create__mmask16_from(0b0101010101010101), 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_sqrt_ph(0 /* __m256h */, create_random__mmask16(), 0 /* __m256h */);
            }
        }
    }
    Ok(())
}
