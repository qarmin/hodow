use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_int_equality, get_random_float32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_comi_round_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(3.0);
        let m = _mm_comi_round_sh(a, a, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let _ = m;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_comi_round_sh(
                    _mm_set1_ps(get_random_float32_array::<1>()[0]),
                    _mm_set1_ps(1.0),
                    _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC,
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_comi_sh() -> Result<(), String> {
    test_mm_comi_round_sh()
}

pub(super) fn test_mm_comieq_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let r = _mm_comieq_sh(a, b);
        check_int_equality(r as i32, 1)?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_comieq_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_comige_sh() -> Result<(), String> {
    test_mm_comieq_sh()
}

pub(super) fn test_mm_comigt_sh() -> Result<(), String> {
    test_mm_comieq_sh()
}

pub(super) fn test_mm_comile_sh() -> Result<(), String> {
    test_mm_comieq_sh()
}

pub(super) fn test_mm_comilt_sh() -> Result<(), String> {
    test_mm_comieq_sh()
}

pub(super) fn test_mm_comineq_sh() -> Result<(), String> {
    test_mm_comieq_sh()
}

pub(super) fn test_mm_ucomieq_sh() -> Result<(), String> {
    test_mm_comieq_sh()
}

pub(super) fn test_mm_ucomige_sh() -> Result<(), String> {
    test_mm_comieq_sh()
}

pub(super) fn test_mm_ucomigt_sh() -> Result<(), String> {
    test_mm_comieq_sh()
}

pub(super) fn test_mm_ucomile_sh() -> Result<(), String> {
    test_mm_comieq_sh()
}

pub(super) fn test_mm_ucomilt_sh() -> Result<(), String> {
    test_mm_comieq_sh()
}

pub(super) fn test_mm_ucomineq_sh() -> Result<(), String> {
    test_mm_comieq_sh()
}

pub(super) fn test_mm_load_ph() -> Result<(), String> {
    unsafe {
        let data = [1.0f32, 2.0, 3.0, 4.0];
        let r = _mm_load_ph(data.as_ptr());
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        crate::cpu::common::check_float_array_equality_with_error(&out, &[1.0, 2.0, 3.0, 4.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_load_ph(get_random_float32_array::<4>().as_ptr());
            }
        }
    }
    Ok(())
}
