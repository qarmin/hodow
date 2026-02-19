use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_mask_roundscale_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_roundscale_ph::<0>(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_roundscale_ph::<0>(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_roundscale_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_roundscale_ph::<0>(create__mmask8_from(0b01010101), 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_roundscale_ph::<0>(create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_roundscale_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_roundscale_sh::<0>(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_roundscale_sh::<0>(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_roundscale_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_roundscale_sh")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_roundscale_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_roundscale_sh::<0>(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_roundscale_sh::<0>(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_roundscale_round_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_roundscale_round_sh::<0, 0>(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_roundscale_round_sh::<0, 0>(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_roundscale_round_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_roundscale_round_sh")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_roundscale_round_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_roundscale_round_sh")
    }
    Ok(())
}

pub(super) fn test_mm_scalef_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_scalef_ph(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_scalef_ph(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_scalef_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_scalef_ph(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_scalef_ph(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_scalef_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_scalef_ph(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_scalef_ph(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_scalef_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_scalef_sh(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_scalef_sh(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_scalef_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_scalef_sh(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_scalef_sh(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_scalef_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_scalef_sh(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_scalef_sh(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_scalef_round_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_scalef_round_sh::<0>(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_scalef_round_sh::<0>(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_scalef_round_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_scalef_round_sh")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_scalef_round_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_scalef_round_sh")
    }
    Ok(())
}

pub(super) fn test_mm_reduce_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_reduce_ph::<0>(0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_reduce_ph::<0>(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_reduce_ph::<0>(0 /* __m128h */, create__mmask8_from(0b01010101), 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_reduce_ph::<0>(0 /* __m128h */, create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_reduce_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_reduce_ph::<0>(create__mmask8_from(0b01010101), 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_reduce_ph::<0>(create_random__mmask8(), 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_reduce_sh::<0>(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_reduce_sh::<0>(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_reduce_sh")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_reduce_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_reduce_sh::<0>(create__mmask8_from(0b01010101), 0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_reduce_sh::<0>(create_random__mmask8(), 0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_round_sh() -> Result<(), String> {
    unsafe {
        let _result = _mm_reduce_round_sh::<0, 0>(0 /* __m128h */, 0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_reduce_round_sh::<0, 0>(0 /* __m128h */, 0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_round_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_reduce_round_sh")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_reduce_round_sh() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_reduce_round_sh")
    }
    Ok(())
}

pub(super) fn test_mm_reduce_add_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_reduce_add_ph(0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_reduce_add_ph(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_mul_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_reduce_mul_ph(0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_reduce_mul_ph(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_min_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_reduce_min_ph(0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_reduce_min_ph(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_max_ph() -> Result<(), String> {
    unsafe {
        let _result = _mm_reduce_max_ph(0 /* __m128h */);

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_reduce_max_ph(0 /* __m128h */);
            }
        }
    }
    Ok(())
}
