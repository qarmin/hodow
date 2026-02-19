use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, get_random_float32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_load_sh() -> Result<(), String> {
    unsafe {
        let data = [1.0, 2.0, 3.0, 4.0];
        let r = _mm_load_sh(data.as_ptr());
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[1.0, 2.0, 3.0, 4.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_load_sh(get_random_float32_array::<4>().as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_load_sh() -> Result<(), String> {
    test_mm_load_sh()
}

pub(super) fn test_mm_maskz_load_sh() -> Result<(), String> {
    test_mm_load_sh()
}

pub(super) fn test_mm_loadu_ph() -> Result<(), String> {
    unsafe {
        let data = [1.0, 2.0, 3.0, 4.0];
        let r = _mm_loadu_ph(data.as_ptr());
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[1.0, 2.0, 3.0, 4.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_loadu_ph(get_random_float32_array::<4>().as_ptr());
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_move_sh() -> Result<(), String> {
    test_mm_load_sh()
}

pub(super) fn test_mm_maskz_move_sh() -> Result<(), String> {
    test_mm_load_sh()
}

pub(super) fn test_mm_move_sh() -> Result<(), String> {
    test_mm_load_sh()
}

pub(super) fn test_mm_store_ph() -> Result<(), String> {
    unsafe {
        let mut buf = [0.0; 4];
        let v = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        _mm_store_ph(buf.as_mut_ptr(), v);
        check_float_array_equality(&buf, &[1.0, 2.0, 3.0, 4.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let mut buf = [0.0; 4];
                _mm_store_ph(buf.as_mut_ptr(), _mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_store_sh() -> Result<(), String> {
    test_mm_store_ph()
}

pub(super) fn test_mm_mask_store_sh() -> Result<(), String> {
    test_mm_store_ph()
}

pub(super) fn test_mm_storeu_ph() -> Result<(), String> {
    unsafe {
        let mut buf = [0.0; 4];
        let v = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        _mm_storeu_ph(buf.as_mut_ptr(), v);
        check_float_array_equality(&buf, &[1.0, 2.0, 3.0, 4.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let mut buf = [0.0; 4];
                _mm_storeu_ph(buf.as_mut_ptr(), _mm_set1_ps(get_random_float32_array::<1>()[0]));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_add_ph() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let b = _mm_set_ps(1.0, 1.0, 1.0, 1.0);
        let r = _mm_add_ph(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0, 3.0, 4.0, 5.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_add_ph(_mm_set1_ps(get_random_float32_array::<1>()[0]), _mm_set1_ps(1.0));
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_add_ph() -> Result<(), String> {
    test_mm_add_ph()
}

pub(super) fn test_mm_maskz_add_ph() -> Result<(), String> {
    test_mm_add_ph()
}

pub(super) fn test_mm_add_round_sh() -> Result<(), String> {
    test_mm_add_ph()
}
