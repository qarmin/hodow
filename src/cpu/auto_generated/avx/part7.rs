use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm256_loadu2_m128() -> Result<(), String> {
    unsafe {
        let ptr_hiaddr = [1.0f32; 1];
        let ptr_loaddr = [1.0f32; 1];
        let result = unpack__m256_to_f32_array(_mm256_loadu2_m128(ptr_hiaddr.as_ptr(), ptr_loaddr.as_ptr()));
        check_array_equality(&result, &[0.0f32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_loadu2_m128d() -> Result<(), String> {
    unsafe {
        let ptr_hiaddr = [1.0f64; 1];
        let ptr_loaddr = [1.0f64; 1];
        let result = unpack__m256d_to_f64_array(_mm256_loadu2_m128d(ptr_hiaddr.as_ptr(), ptr_loaddr.as_ptr()));
        check_array_equality(&result, &[0.0f64; 4])?;
    }
    Ok(())
}

pub(super) fn test_mm256_loadu2_m128i() -> Result<(), String> {
    unsafe {
        let ptr_hiaddr = [create__m128i_from_i32_array([1, 2, 3, 4]); 1];
        let ptr_loaddr = [create__m128i_from_i32_array([1, 2, 3, 4]); 1];
        let result = unpack__m256i_to_i32_array(_mm256_loadu2_m128i(ptr_hiaddr.as_ptr(), ptr_loaddr.as_ptr()));
        check_array_equality(&result, &[0i32; 8])?;
    }
    Ok(())
}

pub(super) fn test_mm256_storeu2_m128() -> Result<(), String> {
    unsafe {
        let mut ptr_hiaddr = [1.0f32; 1];
        let mut ptr_loaddr = [1.0f32; 1];
        let a = create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]);
        _mm256_storeu2_m128(ptr_hiaddr.as_mut_ptr(), ptr_loaddr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm256_storeu2_m128d() -> Result<(), String> {
    unsafe {
        let mut ptr_hiaddr = [1.0f64; 1];
        let mut ptr_loaddr = [1.0f64; 1];
        let a = create__m256d_from([1.0, 2.0, 3.0, 4.0]);
        _mm256_storeu2_m128d(ptr_hiaddr.as_mut_ptr(), ptr_loaddr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm256_storeu2_m128i() -> Result<(), String> {
    unsafe {
        let mut ptr_hiaddr = [create__m128i_from_i32_array([1, 2, 3, 4]); 1];
        let mut ptr_loaddr = [create__m128i_from_i32_array([1, 2, 3, 4]); 1];
        let a = create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]);
        _mm256_storeu2_m128i(ptr_hiaddr.as_mut_ptr(), ptr_loaddr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm256_cvtss_f32() -> Result<(), String> {
    unsafe {
        let _result = _mm256_cvtss_f32(create__m256_from([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]));

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_cvtss_f32(create_random__m256());
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

pub(super) fn test_mm256_extract_epi64() -> Result<(), String> {
    unsafe {
        let result = _mm256_extract_epi64::<0>(create__m256i_from_i32_array([1, 2, 3, 4, 5, 6, 7, 8]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm256_extract_epi64::<0>(create_random__m256i());
            }
        }
    }
    Ok(())
}
