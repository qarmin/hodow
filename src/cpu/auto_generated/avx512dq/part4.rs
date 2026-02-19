use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_reduce_round_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_reduce_round_ss::<0, 0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_reduce_round_ss::<0, 0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_round_ss() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_reduce_round_ss")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_reduce_round_ss() -> Result<(), String> {
    unsafe {
        todo!("_mm_maskz_reduce_round_ss")
    }
    Ok(())
}

pub(super) fn test_mm_reduce_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_reduce_ss::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_reduce_ss::<0>(create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_ss() -> Result<(), String> {
    unsafe {
        todo!("_mm_mask_reduce_ss")
    }
    Ok(())
}

pub(super) fn test_mm_maskz_reduce_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_reduce_ss::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]), create__m128_from([1.0, 2.0, 3.0, 4.0])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_reduce_ss::<0>(create_random__mmask8(), create_random__m128(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fpclass_pd_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_fpclass_pd_mask::<0>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fpclass_pd_mask::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fpclass_pd_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_fpclass_pd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fpclass_pd_mask::<0>(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fpclass_ps_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_fpclass_ps_mask::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fpclass_ps_mask::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fpclass_ps_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_fpclass_ps_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fpclass_ps_mask::<0>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fpclass_sd_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_fpclass_sd_mask::<0>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fpclass_sd_mask::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fpclass_sd_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_fpclass_sd_mask::<0>(create__mmask8_from(0b01010101), create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fpclass_sd_mask::<0>(create_random__mmask8(), create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fpclass_ss_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_fpclass_ss_mask::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_fpclass_ss_mask::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fpclass_ss_mask() -> Result<(), String> {
    unsafe {
        let result = _mm_mask_fpclass_ss_mask::<0>(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_fpclass_ss_mask::<0>(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}
