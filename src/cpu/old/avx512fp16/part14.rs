use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, get_random_float32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_fnmsub_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let b = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let c = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let r = _mm_fnmsub_ph(a, b, c);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[-1.0, -11.0, -20.0, -31.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_fnmsub_ph(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fnmsub_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0, 3.0, 2.0, 1.0);
        let b = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let c = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let r = _mm_fnmsub_sh(a, b, c);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[-3.0, -5.0, -6.0, -3.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_fnmsub_sh(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fnmsub_sh() -> Result<(), String> {
    test_mm_fnmsub_sh()
}

pub(super) fn test_mm_mask3_fnmsub_sh() -> Result<(), String> {
    test_mm_fnmsub_sh()
}

pub(super) fn test_mm_maskz_fnmsub_sh() -> Result<(), String> {
    test_mm_fnmsub_sh()
}

pub(super) fn test_mm_fnmsub_round_sh() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(2.0, 4.0, 6.0, 8.0);
        let b = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let c = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let r = _mm_fnmsub_round_sh(a, b, c);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[-1.0, -3.0, -5.0, -7.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_fnmsub_round_sh(
                    _mm_set1_ps(get_random_float32_array::<1>()[0]),
                    _mm_set1_ps(1.0),
                    _mm_set1_ps(1.0),
                    _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC,
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fnmsub_round_sh() -> Result<(), String> {
    test_mm_fnmsub_round_sh()
}

pub(super) fn test_mm_mask3_fnmsub_round_sh() -> Result<(), String> {
    test_mm_fnmsub_round_sh()
}

pub(super) fn test_mm_maskz_fnmsub_round_sh() -> Result<(), String> {
    test_mm_fnmsub_round_sh()
}

pub(super) fn test_mm_fmaddsub_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let r = _mm_fmaddsub_ph(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0, 2.0, 4.0, 4.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_fmaddsub_ph(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fmaddsub_ph() -> Result<(), String> {
    test_mm_fmaddsub_ph()
}

pub(super) fn test_mm_mask3_fmaddsub_ph() -> Result<(), String> {
    test_mm_fmaddsub_ph()
}

pub(super) fn test_mm_maskz_fmaddsub_ph() -> Result<(), String> {
    test_mm_fmaddsub_ph()
}

pub(super) fn test_mm_mask_fmsubadd_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(2.0, 3.0, 4.0, 5.0);
        let b = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let r = _mm_fmsubadd_ph(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[1.0, 2.0, 3.0, 4.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_fmsubadd_ph(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}
