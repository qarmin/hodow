use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, get_random_float32_array, get_random_float64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask3_fnmadd_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0);
        let b = _mm_set_ss(2.0);
        let c = _mm_set_ss(1.0);
        let r = _mm_fnmadd_ss(a, b, c);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[-1.0, 0.0, 0.0, 0.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let rc = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let c_r = _mm_set_ss(rc[0]);
                let _ = _mm_fnmadd_ss(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fnmadd_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.0);
        let b = _mm_set_sd(2.0);
        let c = _mm_set_sd(1.0);
        let r = _mm_fnmadd_sd(a, b, c);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[-1.0, 0.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let rc = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let c_r = _mm_set_sd(rc[0]);
                let _ = _mm_fnmadd_sd(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fnmadd_sd() -> Result<(), String> {
    test_mm_mask_fnmadd_sd()
}

pub(super) fn test_mm_mask3_fnmadd_sd() -> Result<(), String> {
    test_mm_mask_fnmadd_sd()
}

pub(super) fn test_mm_mask_fnmsub_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0);
        let b = _mm_set_ss(2.0);
        let c = _mm_set_ss(1.0);
        let r = _mm_fnmsub_ss(a, b, c);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[-3.0, 0.0, 0.0, 0.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let rc = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let c_r = _mm_set_ss(rc[0]);
                let _ = _mm_fnmsub_ss(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fnmsub_ss() -> Result<(), String> {
    test_mm_mask_fnmsub_ss()
}

pub(super) fn test_mm_mask3_fnmsub_ss() -> Result<(), String> {
    test_mm_mask_fnmsub_ss()
}

pub(super) fn test_mm_mask_fnmsub_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(2.0);
        let b = _mm_set_sd(2.0);
        let c = _mm_set_sd(1.0);
        let r = _mm_fnmsub_sd(a, b, c);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[-3.0, 0.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let rc = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let c_r = _mm_set_sd(rc[0]);
                let _ = _mm_fnmsub_sd(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fnmsub_sd() -> Result<(), String> {
    test_mm_mask_fnmsub_sd()
}

pub(super) fn test_mm_mask3_fnmsub_sd() -> Result<(), String> {
    test_mm_mask_fnmsub_sd()
}

pub(super) fn test_mm_add_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.5);
        let b = _mm_set_ss(2.5);
        let r = _mm_add_round_ss(a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        // 1.5 + 2.5 = 4.0 -> rounded to 4
        check_float_array_equality(&out, &[4.0, 0.0, 0.0, 0.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let _ = _mm_add_round_ss(a_r, b_r, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_add_round_ss() -> Result<(), String> {
    test_mm_add_round_ss()
}

pub(super) fn test_mm_maskz_add_round_ss() -> Result<(), String> {
    test_mm_add_round_ss()
}

pub(super) fn test_mm_add_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.5);
        let b = _mm_set_sd(2.5);
        let r = _mm_add_round_sd(a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[4.0, 0.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let _ = _mm_add_round_sd(a_r, b_r, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_add_round_sd() -> Result<(), String> {
    test_mm_add_round_sd()
}

pub(super) fn test_mm_maskz_add_round_sd() -> Result<(), String> {
    test_mm_add_round_sd()
}
