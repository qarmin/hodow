use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_bcstnebf16_ps() -> Result<(), String> {
    unsafe {
        let ptr_a = [0 /* bf16 */; 1];
        let result = unpack__m128_to_f32_array(_mm_bcstnebf16_ps(ptr_a.as_ptr()));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_bcstnesh_ps() -> Result<(), String> {
    unsafe {
        let ptr_a = [0 /* f16 */; 1];
        let result = unpack__m128_to_f32_array(_mm_bcstnesh_ps(ptr_a.as_ptr()));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_cvtneebf16_ps() -> Result<(), String> {
    unsafe {
        let ptr_a = [create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]); 1];
        let result = unpack__m128_to_f32_array(_mm_cvtneebf16_ps(ptr_a.as_ptr()));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_cvtneeph_ps() -> Result<(), String> {
    unsafe {
        let ptr_a = [0 /* __m128h */; 1];
        let result = unpack__m128_to_f32_array(_mm_cvtneeph_ps(ptr_a.as_ptr()));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_cvtneobf16_ps() -> Result<(), String> {
    unsafe {
        let ptr_a = [create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]); 1];
        let result = unpack__m128_to_f32_array(_mm_cvtneobf16_ps(ptr_a.as_ptr()));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_cvtneoph_ps() -> Result<(), String> {
    unsafe {
        let ptr_a = [0 /* __m128h */; 1];
        let result = unpack__m128_to_f32_array(_mm_cvtneoph_ps(ptr_a.as_ptr()));
        check_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm_cvtneps_avx_pbh() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtneps_avx_pbh(create__m128_from([1.0, 2.0, 3.0, 4.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtneps_avx_pbh(create_random__m128());
            }
        }
    }
    Ok(())
}
