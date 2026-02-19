use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_scalef_round_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_scalef_round_sd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_scalef_round_sd::<0>(create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_scalef_round_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_scalef_round_sd")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_scalef_round_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_scalef_round_sd")
    }
    Ok(())
}

pub(super) fn test_mm_fmadd_round_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmadd_round_ss::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fmadd_round_ss::<0>(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fmadd_round_ss() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_fmadd_round_ss")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fmadd_round_ss() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_fmadd_round_ss")
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fmadd_round_ss() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask3_fmadd_round_ss")
    }
    Ok(())
}

pub(super) fn test_mm_fmadd_round_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmadd_round_sd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fmadd_round_sd::<0>(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fmadd_round_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_fmadd_round_sd")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fmadd_round_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_fmadd_round_sd")
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fmadd_round_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask3_fmadd_round_sd")
    }
    Ok(())
}

pub(super) fn test_mm_fmsub_round_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fmsub_round_ss::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fmsub_round_ss::<0>(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fmsub_round_ss() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_fmsub_round_ss")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fmsub_round_ss() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_fmsub_round_ss")
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fmsub_round_ss() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask3_fmsub_round_ss")
    }
    Ok(())
}

pub(super) fn test_mm_fmsub_round_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fmsub_round_sd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fmsub_round_sd::<0>(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fmsub_round_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_fmsub_round_sd")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fmsub_round_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_fmsub_round_sd")
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fmsub_round_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask3_fmsub_round_sd")
    }
    Ok(())
}

pub(super) fn test_mm_fnmadd_round_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmadd_round_ss::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fnmadd_round_ss::<0>(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fnmadd_round_ss() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_fnmadd_round_ss")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fnmadd_round_ss() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_fnmadd_round_ss")
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fnmadd_round_ss() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask3_fnmadd_round_ss")
    }
    Ok(())
}

pub(super) fn test_mm_fnmadd_round_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmadd_round_sd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fnmadd_round_sd::<0>(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fnmadd_round_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_fnmadd_round_sd")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fnmadd_round_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_fnmadd_round_sd")
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fnmadd_round_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask3_fnmadd_round_sd")
    }
    Ok(())
}

pub(super) fn test_mm_fnmsub_round_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fnmsub_round_ss::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fnmsub_round_ss::<0>(create_random__m128(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fnmsub_round_ss() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_fnmsub_round_ss")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fnmsub_round_ss() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_fnmsub_round_ss")
    }
    Ok(())
}
