use std::arch::x86_64::*;

#[allow(unused_imports)]
use crate::cpu::common::values::*;
#[allow(unused_imports)]
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_sfence() -> Result<(), String> {
    unsafe {
        _mm_sfence();

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_sfence();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_prefetch() -> Result<(), String> {
    unsafe {
        let ptr_p = [1i8; 1];
        _mm_prefetch::<0>(ptr_p.as_ptr());
    }
    Ok(())
}

pub(super) fn test_mm_undefined_ps() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_undefined_ps());
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_undefined_ps();
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_stream_ps() -> Result<(), String> {
    unsafe {
        let mut ptr_mem_addr = [1.0f32; 1];
        let a = create__m128_from([2.0, 3.0, 4.0, 5.0]);
        _mm_stream_ps(ptr_mem_addr.as_mut_ptr(), a);
    }
    Ok(())
}

pub(super) fn test_mm_cvtss_si64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtss_si64(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtss_si64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttss_si64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttss_si64(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvttss_si64(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtsi64_ss() -> Result<(), String> {
    unsafe {
        let result = unpack__m128_to_f32_array(_mm_cvtsi64_ss(create__m128_from([1.0, 2.0, 3.0, 4.0]), 5i64));
        check_array_equality(&result, &[0.0f32; 4])?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtsi64_ss(create_random__m128(), rand::random::<i64>());
            }
        }
    }
    Ok(())
}
