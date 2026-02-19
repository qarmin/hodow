use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_setr_epi64x() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_setr_epi64x(1i64, 1i64));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_setr_epi64x(rand::random::<i64>(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_insert_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m128i_to_i32_array(_mm_insert_epi64::<0>(create__m128i_from_i32_array([1, 2, 3, 4]), 1i64));
        check_array_equality(&result, &[0i32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_insert_epi64::<0>(create_random__m128i(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_insert_epi64() -> Result<(), String> {
    unsafe {
        let result = unpack__m256i_to_i32_array(_mm256_insert_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]), 1i64));
        check_array_equality(&result, &[0i32; 8])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_insert_epi64::<0>(create_random__m256i(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}
