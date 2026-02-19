use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_cvt_roundsh_u64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_roundsh_u64::<0>(0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundsh_u64::<0>(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttsh_i64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsh_i64(0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvttsh_i64(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundsh_i64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_roundsh_i64::<0>(0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtt_roundsh_i64::<0>(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvttsh_u64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvttsh_u64(0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvttsh_u64(0 /* __m128h */);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundsh_u64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_roundsh_u64::<0>(0 /* __m128h */);
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtt_roundsh_u64::<0>(0 /* __m128h */);
            }
        }
    }
    Ok(())
}
