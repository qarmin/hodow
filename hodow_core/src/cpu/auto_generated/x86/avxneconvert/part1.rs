use std::arch::x86::*;

#[allow(unused_imports)]
use crate::cpu::common::x86::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_float_array_equality, check_int_equality};

pub(super) fn test_mm_cvtneebf16_ps() -> Result<(), String> {
    unsafe {
        let ptr_a = [create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]); 1];
        let result = unpack__m128_to_f32_array(_mm_cvtneebf16_ps(ptr_a.as_ptr()));
        check_float_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm256_cvtneebf16_ps() -> Result<(), String> {
    unsafe {
        let ptr_a = [create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]); 1];
        let result = unpack__m256_to_f32_array(_mm256_cvtneebf16_ps(ptr_a.as_ptr()));
        check_float_array_equality(&result, &[0.0f32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm_cvtneobf16_ps() -> Result<(), String> {
    unsafe {
        let ptr_a = [create__m128bh_from([1, 2, 3, 4, 5, 6, 7, 8]); 1];
        let result = unpack__m128_to_f32_array(_mm_cvtneobf16_ps(ptr_a.as_ptr()));
        check_float_array_equality(&result, &[0.0f32; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm256_cvtneobf16_ps() -> Result<(), String> {
    unsafe {
        let ptr_a = [create__m256bh_from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]); 1];
        let result = unpack__m256_to_f32_array(_mm256_cvtneobf16_ps(ptr_a.as_ptr()));
        check_float_array_equality(&result, &[0.0f32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm_cvtneps_avx_pbh() -> Result<(), String> {
    unsafe {
        let _result = _mm_cvtneps_avx_pbh(create__m128_from([1.0, 2.0, 3.0, 4.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm_cvtneps_avx_pbh(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm256_cvtneps_avx_pbh() -> Result<(), String> {
    unsafe {
        let _result = _mm256_cvtneps_avx_pbh(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            let total_iters = crate::cpu::get_iterations();
            for i in 0..total_iters {
                if i % 1000 == 0 && crate::cpu::should_stop() {
                    log::info!("Fuzzing stopped at iteration {}", i);
                    break;
                }
                let _ = _mm256_cvtneps_avx_pbh(create_random__m256());
            }
        }
    }
    Ok(())
}
