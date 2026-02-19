use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_mask_max_round_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_max_round_sh")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_max_round_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_max_round_sh::<0>(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_max_round_sh::<0>(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_min_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_min_ph(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_min_ph(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_min_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_min_ph(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_min_ph(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_min_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_min_ph(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_min_ph(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_min_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_min_sh(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_min_sh(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_min_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_min_sh(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_min_sh(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_min_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_min_sh(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_min_sh(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_min_round_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_min_round_sh::<0>(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_min_round_sh::<0>(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_min_round_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_min_round_sh")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_min_round_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_min_round_sh::<0>(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_min_round_sh::<0>(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_getexp_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_getexp_ph(0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_getexp_ph(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_getexp_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_getexp_ph(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_getexp_ph(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_getexp_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_getexp_ph(create__mmask8_from(0b01010101), 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_getexp_ph(create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_getexp_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_getexp_sh(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_getexp_sh(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_getexp_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_getexp_sh(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_getexp_sh(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_getexp_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_getexp_sh(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_getexp_sh(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_getexp_round_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_getexp_round_sh::<0>(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_getexp_round_sh::<0>(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_getexp_round_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_getexp_round_sh")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_getexp_round_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_getexp_round_sh::<0>(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_getexp_round_sh::<0>(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_getmant_ph() -> Result<(), String> {
    unsafe {
        todo!("_mm_getmant_ph")
    }
    Ok(())
}

pub(super) fn test_mm_mask_getmant_ph() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_getmant_ph")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_getmant_ph() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_getmant_ph")
    }
    Ok(())
}

pub(super) fn test_mm_getmant_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_getmant_sh")
    }
    Ok(())
}

pub(super) fn test_mm_mask_getmant_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_getmant_sh")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_getmant_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_getmant_sh")
    }
    Ok(())
}

pub(super) fn test_mm_getmant_round_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_getmant_round_sh")
    }
    Ok(())
}

pub(super) fn test_mm_mask_getmant_round_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_getmant_round_sh")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_getmant_round_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_getmant_round_sh")
    }
    Ok(())
}

pub(super) fn test_mm_roundscale_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_roundscale_ph::<0>(0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_roundscale_ph::<0>(0 /* __m128h */);
            }
        }
    }
    Ok(())
}
