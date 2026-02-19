use std::arch::x86_64::*;

use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_cvtpbh_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtpbh_ps(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtpbh_ps(create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtpbh_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_mask_cvtpbh_ps(create__m128_from([1.0, 2.0, 3.0, 4.0]), create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvtpbh_ps(create_random__m128(), create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtpbh_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_maskz_cvtpbh_ps(create__mmask8_from(0b01010101), create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8])));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvtpbh_ps(create_random__mmask8(), create_random__m128bh());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtneps_pbh() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtneps_pbh(create__m128_from([1.0, 2.0, 3.0, 4.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtneps_pbh(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_cvtneps_pbh() -> Result<(), String> {
    unsafe {
        let _result = _mm_mask_cvtneps_pbh(create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]), create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_mask_cvtneps_pbh(create_random__m128bh(), create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_cvtneps_pbh() -> Result<(), String> {
    unsafe {
        let _result = _mm_maskz_cvtneps_pbh(create__mmask8_from(0b01010101), create__m128_from([1.0, 2.0, 3.0, 4.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_maskz_cvtneps_pbh(create_random__mmask8(), create_random__m128());
            }
        }
    }
    Ok(())
}
