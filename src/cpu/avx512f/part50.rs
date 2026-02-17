use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, get_random_float32_array, get_random_float64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_sub_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(5.5f32);
        let b = _mm_set_ss(1.5f32);
        let r = _mm_sub_round_ss(a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        // 5.5 - 1.5 = 4.0 -> rounded to 4
        check_float_array_equality(&out, &[4.0f32, 0.0f32, 0.0f32, 0.0f32])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let _ = _mm_sub_round_ss(a_r, b_r, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_sub_round_ss() -> Result<(), String> {
    test_mm_sub_round_ss()
}

pub(super) fn test_mm_maskz_sub_round_ss() -> Result<(), String> {
    test_mm_sub_round_ss()
}

pub(super) fn test_mm_sub_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(6.5f64);
        let b = _mm_set_sd(2.5f64);
        let r = _mm_sub_round_sd(a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[4.0f64, 0.0f64])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let _ = _mm_sub_round_sd(a_r, b_r, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_sub_round_sd() -> Result<(), String> {
    test_mm_sub_round_sd()
}

pub(super) fn test_mm_maskz_sub_round_sd() -> Result<(), String> {
    test_mm_sub_round_sd()
}

pub(super) fn test_mm_mul_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.0f32);
        let b = _mm_set_ss(4.0f32);
        let r = _mm_mul_round_ss(a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[4.0f32, 0.0f32, 0.0f32, 0.0f32])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let _ = _mm_mul_round_ss(a_r, b_r, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_mul_round_ss() -> Result<(), String> {
    test_mm_mul_round_ss()
}

pub(super) fn test_mm_maskz_mul_round_ss() -> Result<(), String> {
    test_mm_mul_round_ss()
}

pub(super) fn test_mm_mul_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(2.5f64);
        let b = _mm_set_sd(2.0f64);
        let r = _mm_mul_round_sd(a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[5.0f64, 0.0f64])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let _ = _mm_mul_round_sd(a_r, b_r, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_mul_round_sd() -> Result<(), String> {
    test_mm_mul_round_sd()
}

pub(super) fn test_mm_maskz_mul_round_sd() -> Result<(), String> {
    test_mm_mul_round_sd()
}

pub(super) fn test_mm_div_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(8.0f32);
        let b = _mm_set_ss(2.0f32);
        let r = _mm_div_round_ss(a, b, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[4.0f32, 0.0f32, 0.0f32, 0.0f32])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let _ = _mm_div_round_ss(a_r, b_r, _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_div_round_ss() -> Result<(), String> {
    test_mm_div_round_ss()
}
