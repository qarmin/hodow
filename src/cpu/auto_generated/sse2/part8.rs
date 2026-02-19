use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_cvtsi64_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64_sd(create__m128d_from([1.0, 2.0]), 3i64));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtsi64_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsi64x_sd() -> Result<(), String> {
    unsafe {
        let result = unpack__m128d_to_f64_array(_mm_cvtsi64x_sd(create__m128d_from([1.0, 2.0]), 3i64));
        check_array_equality(&result, &[0.0f64; 2])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtsi64x_sd(create_random__m128d(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}
