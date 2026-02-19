use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_mask_cmul_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_cmul_sch(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cmul_sch(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cmul_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_cmul_sch(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cmul_sch(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cmul_round_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_cmul_round_sch::<0>(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cmul_round_sch::<0>(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cmul_round_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_cmul_round_sch::<0>(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cmul_round_sch::<0>(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cmul_round_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_cmul_round_sch::<0>(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cmul_round_sch::<0>(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fcmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm_fcmul_pch(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fcmul_pch(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fcmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_fcmul_pch(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fcmul_pch(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fcmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_fcmul_pch(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_fcmul_pch(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_fcmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm256_fcmul_pch(0 /* __m256h */, 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_fcmul_pch(0 /* __m256h */, 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_mask_fcmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm256_mask_fcmul_pch(0 /* __m256h */, create__mmask8_from(0b01010101), 0 /* __m256h */, 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_mask_fcmul_pch(0 /* __m256h */, create_random__mmask8(), 0 /* __m256h */, 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_maskz_fcmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm256_maskz_fcmul_pch(create__mmask8_from(0b01010101), 0 /* __m256h */, 0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_maskz_fcmul_pch(create_random__mmask8(), 0 /* __m256h */, 0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_fcmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_fcmul_pch(0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_fcmul_pch(0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_fcmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_fcmul_pch(0 /* __m512h */, create__mmask16_from(0b0101010101010101), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_fcmul_pch(0 /* __m512h */, create_random__mmask16(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_fcmul_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_fcmul_pch(create__mmask16_from(0b0101010101010101), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_fcmul_pch(create_random__mmask16(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_fcmul_round_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_fcmul_round_pch::<0>(0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_fcmul_round_pch::<0>(0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_mask_fcmul_round_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_mask_fcmul_round_pch::<0>(0 /* __m512h */, create__mmask16_from(0b0101010101010101), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_mask_fcmul_round_pch::<0>(0 /* __m512h */, create_random__mmask16(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_maskz_fcmul_round_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm512_maskz_fcmul_round_pch::<0>(create__mmask16_from(0b0101010101010101), 0 /* __m512h */, 0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_maskz_fcmul_round_pch::<0>(create_random__mmask16(), 0 /* __m512h */, 0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fcmul_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_fcmul_sch(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fcmul_sch(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fcmul_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_fcmul_sch(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fcmul_sch(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fcmul_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_fcmul_sch(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_fcmul_sch(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fcmul_round_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_fcmul_round_sch::<0>(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fcmul_round_sch::<0>(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fcmul_round_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_fcmul_round_sch::<0>(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fcmul_round_sch::<0>(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fcmul_round_sch() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_fcmul_round_sch::<0>(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_fcmul_round_sch::<0>(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_abs_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_abs_ph(0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_abs_ph(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_abs_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm256_abs_ph(0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_abs_ph(0 /* __m256h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm512_abs_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm512_abs_ph(0 /* __m512h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm512_abs_ph(0 /* __m512h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_conj_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm_conj_pch(0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_conj_pch(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_conj_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_conj_pch(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_conj_pch(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_conj_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_conj_pch(create__mmask8_from(0b01010101), 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_conj_pch(create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_conj_pch() -> Result<(), String> {
    unsafe {
        let _result = _mm256_conj_pch(0 /* __m256h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_conj_pch(0 /* __m256h */);
            }
        }
    }
    Ok(())
}
