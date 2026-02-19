use std::arch::x86_64::*;

use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_extract_si64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_extract_si64(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_extract_si64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_extracti_si64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_extracti_si64::<0, 0>(create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_extracti_si64::<0, 0>(create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_insert_si64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_insert_si64(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_insert_si64(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_inserti_si64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_inserti_si64::<0, 0>(create__m128i_from_i32_array([1, 2, 3, 4]), create__m128i_from_i32_array([1, 2, 3, 4])));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_inserti_si64::<0, 0>(create_random__m128i(), create_random__m128i());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_stream_sd() -> Result<(), String> {
    unsafe {
        let mut ptr_p = [1.0f64; 1];
        let a = create__m128d_from([1.0, 2.0]);
        _mm_stream_sd(ptr_p.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_stream_ss() -> Result<(), String> {
    unsafe {
        let mut ptr_p = [1.0f32; 1];
        let a = create__m128_from([1.0, 2.0, 3.0, 4.0]);
        _mm_stream_ss(ptr_p.as_mut_ptr(), a);
    }
    Ok(())
}
