use std::arch::x86_64::*;

use crate::cpu::common::values::*;
use crate::cpu::common::{check_array_equality, check_int_equality};

pub(super) fn test_mm_cvt_roundss_i64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_roundss_i64::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundss_i64::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvt_roundss_u64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvt_roundss_u64::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvt_roundss_u64::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundsd_si64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_roundsd_si64::<0>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtt_roundsd_si64::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundsd_i64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_roundsd_i64::<0>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtt_roundsd_i64::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundsd_u64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_roundsd_u64::<0>(create__m128d_from([1.0, 2.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtt_roundsd_u64::<0>(create_random__m128d());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundss_i64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_roundss_i64::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtt_roundss_i64::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundss_si64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_roundss_si64::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtt_roundss_si64::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_cvtt_roundss_u64() -> Result<(), String> {
    unsafe {
        let result = _mm_cvtt_roundss_u64::<0>(create__m128_from([1.0, 2.0, 3.0, 4.0]));
        check_int_equality(result as i32, 0)?;

        if crate::get_fuzzing() {
            log::info!("Starting fuzzing");
            for _ in 0..crate::cpu::get_iterations() {
                let _ = _mm_cvtt_roundss_u64::<0>(create_random__m128());
            }
        }
    }
    Ok(())
}
