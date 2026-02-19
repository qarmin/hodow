use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_mask3_fnmsub_round_ss() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask3_fnmsub_round_ss")
    }
    Ok(())
}

pub(super) fn test_mm_fnmsub_round_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fnmsub_round_sd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fnmsub_round_sd::<0>(create_random__m128d(), create_random__m128d(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fnmsub_round_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_fnmsub_round_sd")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fnmsub_round_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_fnmsub_round_sd")
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fnmsub_round_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask3_fnmsub_round_sd")
    }
    Ok(())
}

pub(super) fn test_mm_fixupimm_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_fixupimm_ss::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fixupimm_ss::<0>(create_random__m128(), create_random__m128(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fixupimm_ss() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_fixupimm_ss")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fixupimm_ss() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_fixupimm_ss")
    }
    Ok(())
}

pub(super) fn test_mm_fixupimm_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_fixupimm_sd::<0>(create__m128d_from([1.0, 2.0]), create__m128d_from([1.0, 2.0]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fixupimm_sd::<0>(create_random__m128d(), create_random__m128d(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fixupimm_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_fixupimm_sd")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fixupimm_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_fixupimm_sd")
    }
    Ok(())
}

pub(super) fn test_mm_fixupimm_round_ss() -> Result<(), String> {
    unsafe {
        todo!("_mm_fixupimm_round_ss")
    }
    Ok(())
}

pub(super) fn test_mm_mask_fixupimm_round_ss() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_fixupimm_round_ss")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fixupimm_round_ss() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_fixupimm_round_ss")
    }
    Ok(())
}

pub(super) fn test_mm_fixupimm_round_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_fixupimm_round_sd")
    }
    Ok(())
}

pub(super) fn test_mm_mask_fixupimm_round_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_fixupimm_round_sd")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fixupimm_round_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_fixupimm_round_sd")
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtss_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_mask_cvtss_sd(create__m128d_from([1.0, 2.0]), create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvtss_sd(create_random__m128d(), create_random__mmask8(), create_random__m128d(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtss_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_cvtss_sd(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvtss_sd(create_random__mmask8(), create_random__m128d(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtsd_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtsd_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvtsd_ss(create_random__m128(), create_random__mmask8(), create_random__m128(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtsd_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_cvtsd_ss(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvtsd_ss(create_random__mmask8(), create_random__m128(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundss_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvt_roundss_sd::<0>(create__m128d_from([1.0, 2.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundss_sd::<0>(create_random__m128d(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvt_roundss_sd() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_cvt_roundss_sd")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvt_roundss_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_maskz_cvt_roundss_sd::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvt_roundss_sd::<0>(create_random__mmask8(), create_random__m128d(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundsd_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvt_roundsd_ss::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundsd_ss::<0>(create_random__m128(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvt_roundsd_ss() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_cvt_roundsd_ss")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvt_roundsd_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_cvt_roundsd_ss::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128d_from([1.0, 2.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvt_roundsd_ss::<0>(create_random__mmask8(), create_random__m128(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundss_si32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_roundss_si32::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundss_si32::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundss_i32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_roundss_i32::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundss_i32::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundss_u32() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_roundss_u32::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundss_u32::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}
