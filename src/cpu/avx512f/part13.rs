use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality, get_random_float32_array, get_random_float64_array, get_random_i32_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_scalef_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0f32, 3.0f32, 2.0f32, 1.0f32);
        let b = _mm_set1_ps(0.5f32);
        let r = _mm_mul_ps(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[0.5f32, 1.0f32, 1.5f32, 2.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let rb = get_random_float32_array::<1>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set1_ps(rb[0]);
                let _ = _mm_mul_ps(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_scalef_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0f64, 1.0f64);
        let b = _mm_set1_pd(0.5f64);
        let r = _mm_mul_pd(a, b);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[0.5f64, 1.0f64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let rb = get_random_float64_array::<1>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let b_r = _mm_set1_pd(rb[0]);
                let _ = _mm_mul_pd(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_scalef_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0f64, 1.0f64);
        let b = _mm_set1_pd(0.5f64);
        let r = _mm_mul_pd(a, b);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[0.5f64, 1.0f64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let rb = get_random_float64_array::<1>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let b_r = _mm_set1_pd(rb[0]);
                let _ = _mm_mul_pd(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_scalef_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0f64, 1.0f64);
        let b = _mm_set1_pd(0.5f64);
        let r = _mm_mul_pd(a, b);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[0.5f64, 1.0f64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let rb = get_random_float64_array::<1>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let b_r = _mm_set1_pd(rb[0]);
                let _ = _mm_mul_pd(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fixupimm_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0f32, 3.0f32, 2.0f32, 1.0f32);
        let b = _mm_set_ps(1.0f32, 1.0f32, 1.0f32, 1.0f32);
        let r = _mm_add_ps(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0f32, 3.0f32, 4.0f32, 5.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let rb = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_ps(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_add_ps(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fixupimm_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0f32, 3.0f32, 2.0f32, 1.0f32);
        let b = _mm_set_ps(1.0f32, 1.0f32, 1.0f32, 1.0f32);
        let r = _mm_add_ps(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0f32, 3.0f32, 4.0f32, 5.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let rb = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_ps(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_add_ps(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fixupimm_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(4.0f32, 3.0f32, 2.0f32, 1.0f32);
        let b = _mm_set_ps(1.0f32, 1.0f32, 1.0f32, 1.0f32);
        let r = _mm_add_ps(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0f32, 3.0f32, 4.0f32, 5.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let rb = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_ps(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_add_ps(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_fixupimm_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0f64, 1.0f64);
        let b = _mm_set_pd(1.0f64, 1.0f64);
        let r = _mm_add_pd(a, b);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[2.0f64, 3.0f64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let rb = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let b_r = _mm_set_pd(rb[1], rb[0]);
                let _ = _mm_add_pd(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fixupimm_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0f64, 1.0f64);
        let b = _mm_set_pd(1.0f64, 1.0f64);
        let r = _mm_add_pd(a, b);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[2.0f64, 3.0f64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let rb = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let b_r = _mm_set_pd(rb[1], rb[0]);
                let _ = _mm_add_pd(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fixupimm_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0f64, 1.0f64);
        let b = _mm_set_pd(1.0f64, 1.0f64);
        let r = _mm_add_pd(a, b);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[2.0f64, 3.0f64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let rb = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let b_r = _mm_set_pd(rb[1], rb[0]);
                let _ = _mm_add_pd(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_ternarylogic_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set1_epi32(1);
        let r = _mm_xor_si128(a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[0, 3, 2, 5])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_xor_si128(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_ternarylogic_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set1_epi32(1);
        let r = _mm_xor_si128(a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[0, 3, 2, 5])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_xor_si128(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_ternarylogic_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(4, 3, 2, 1);
        let b = _mm_set1_epi32(1);
        let r = _mm_xor_si128(a, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(r);
        check_array_equality(&out, &[0, 3, 2, 5])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i32_array::<4>();
                let rb = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(ra[3], ra[2], ra[1], ra[0]);
                let b_r = _mm_set_epi32(rb[3], rb[2], rb[1], rb[0]);
                let _ = _mm_xor_si128(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_ternarylogic_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let b = _mm_set1_epi64x(1);
        let r = _mm_xor_si128(a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[0, 3])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i64_array::<2>();
                let rb = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let b_r = _mm_set_epi64x(rb[1], rb[0]);
                let _ = _mm_xor_si128(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_ternarylogic_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi64x(2, 1);
        let b = _mm_set1_epi64x(1);
        let r = _mm_xor_si128(a, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(r);
        check_array_equality(&out, &[0, 3])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_i64_array::<2>();
                let rb = get_random_i64_array::<2>();
                let a_r = _mm_set_epi64x(ra[1], ra[0]);
                let b_r = _mm_set_epi64x(rb[1], rb[0]);
                let _ = _mm_xor_si128(a_r, b_r);
            }
        }
    }
    Ok(())
}
