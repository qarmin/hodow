use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality, get_random_float32_array, get_random_float64_array, get_random_i32_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_sllv_epi64() -> Result<(), String> {
    unsafe {
        let src: __m128i = _mm_setzero_si128();
        let a = _mm_set1_epi64x(1);
        let count = _mm_set_epi64x(2, 0);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_mask_sllv_epi64(src, k, a, count);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result_v);
        check_array_equality(&result, &[1, 4])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set1_epi64x(rv[0]);
                let count_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_mask_sllv_epi64(src, k, a_r, count_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_sllv_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1);
        let count = _mm_set_epi64x(2, 0);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_maskz_sllv_epi64(k, a, count);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result_v);
        check_array_equality(&result, &[1, 4])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set1_epi64x(rv[0]);
                let count_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_maskz_sllv_epi64(k, a_r, count_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_srlv_epi64() -> Result<(), String> {
    unsafe {
        let src: __m128i = _mm_setzero_si128();
        let a = _mm_set1_epi64x(8);
        let count = _mm_set_epi64x(2, 0);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_mask_srlv_epi64(src, k, a, count);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result_v);
        check_array_equality(&result, &[8, 2])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set1_epi64x(rv[0]);
                let count_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_mask_srlv_epi64(src, k, a_r, count_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_srlv_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(8);
        let count = _mm_set_epi64x(2, 0);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_maskz_srlv_epi64(k, a, count);
        let result = std::mem::transmute::<__m128i, [i64; 2]>(result_v);
        check_array_equality(&result, &[8, 2])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let rv = get_random_i64_array::<2>();
                let a_r = _mm_set1_epi64x(rv[0]);
                let count_r = _mm_set_epi64x(rv[1], rv[0]);
                let _ = _mm_maskz_srlv_epi64(k, a_r, count_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_permute_ps() -> Result<(), String> {
    unsafe {
        let src: __m128 = _mm_setzero_ps();
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let k: __mmask8 = 255u8 as __mmask8;
        let r = _mm_mask_permute_ps(src, k, a, 27);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[1.0f32, 2.0f32, 3.0f32, 4.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let _ = _mm_mask_permute_ps(src, k, a_r, 0);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_permute_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let k: __mmask8 = 255u8 as __mmask8;
        let r = _mm_maskz_permute_ps(k, a, 27);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[1.0f32, 2.0f32, 3.0f32, 4.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let _ = _mm_maskz_permute_ps(k, a_r, 0);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_permute_pd() -> Result<(), String> {
    unsafe {
        let src: __m128d = _mm_setzero_pd();
        let a = _mm_set_pd(2.0f64, 1.0f64);
        let k: __mmask8 = 255u8 as __mmask8;
        let r = _mm_mask_permute_pd(src, k, a, 0);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[1.0f64, 2.0f64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let _ = _mm_mask_permute_pd(src, k, a_r, 0);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_permute_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0f64, 1.0f64);
        let k: __mmask8 = 255u8 as __mmask8;
        let r = _mm_maskz_permute_pd(k, a, 0);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[1.0f64, 2.0f64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let _ = _mm_maskz_permute_pd(k, a_r, 0);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_permutevar_ps() -> Result<(), String> {
    unsafe {
        let src: __m128 = _mm_setzero_ps();
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let idx = _mm_set_epi32(0, 1, 2, 3);
        let k: __mmask8 = 255u8 as __mmask8;
        let r = _mm_mask_permutevar_ps(src, k, a, idx);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[4.0f32, 3.0f32, 2.0f32, 1.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let idx_r = _mm_set1_epi32(0);
                let _ = _mm_mask_permutevar_ps(src, k, a_r, idx_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_permutevar_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let idx = _mm_set_epi32(0, 1, 2, 3);
        let k: __mmask8 = 255u8 as __mmask8;
        let r = _mm_maskz_permutevar_ps(k, a, idx);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[4.0f32, 3.0f32, 2.0f32, 1.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let idx_r = _mm_set1_epi32(0);
                let _ = _mm_maskz_permutevar_ps(k, a_r, idx_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_permutevar_pd() -> Result<(), String> {
    unsafe {
        let src: __m128d = _mm_setzero_pd();
        let a = _mm_set_pd(1.0f64, 2.0f64);
        let idx = _mm_set_epi32(1, 0, 0, 1);
        let k: __mmask8 = 255u8 as __mmask8;
        let r = _mm_mask_permutevar_pd(src, k, a, idx);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[2.0f64, 1.0f64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let idx_r = _mm_set1_epi32(0);
                let _ = _mm_mask_permutevar_pd(src, k, a_r, idx_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_permutevar_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0f64, 2.0f64);
        let idx = _mm_set_epi32(1, 0, 0, 1);
        let k: __mmask8 = 255u8 as __mmask8;
        let r = _mm_maskz_permutevar_pd(k, a, idx);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[2.0f64, 1.0f64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let idx_r = _mm_set1_epi32(0);
                let _ = _mm_maskz_permutevar_pd(k, a_r, idx_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_permutex2var_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(1);
        let idx = _mm_set_epi32(3, 2, 1, 0);
        let result = _mm_permutex2var_epi32(a, idx, a);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&out, &[1, 1, 1, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a_vals = get_random_i32_array::<1>();
                let idx_vals = get_random_i32_array::<4>();
                let a_r = _mm_set1_epi32(a_vals[0]);
                let idx_r = _mm_set_epi32(idx_vals[3], idx_vals[2], idx_vals[1], idx_vals[0]);
                let _ = _mm_permutex2var_epi32(a_r, idx_r, a_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_permutex2var_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(1);
        let idx = _mm_set_epi32(3, 2, 1, 0);
        let b = _mm_set1_epi32(2);
        let k: __mmask8 = 255u8 as __mmask8;
        let result = _mm_mask_permutex2var_epi32(a, k, idx, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&out, &[1, 1, 1, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a_vals = get_random_i32_array::<1>();
                let idx_vals = get_random_i32_array::<4>();
                let b_vals = get_random_i32_array::<1>();
                let a_r = _mm_set1_epi32(a_vals[0]);
                let idx_r = _mm_set_epi32(idx_vals[3], idx_vals[2], idx_vals[1], idx_vals[0]);
                let b_r = _mm_set1_epi32(b_vals[0]);
                let _ = _mm_mask_permutex2var_epi32(a_r, k, idx_r, b_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_permutex2var_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(1);
        let idx = _mm_set_epi32(3, 2, 1, 0);
        let b = _mm_set1_epi32(2);
        let k: __mmask8 = 255u8 as __mmask8;
        let result = _mm_maskz_permutex2var_epi32(k, a, idx, b);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&out, &[1, 1, 1, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a_vals = get_random_i32_array::<1>();
                let idx_vals = get_random_i32_array::<4>();
                let b_vals = get_random_i32_array::<1>();
                let a_r = _mm_set1_epi32(a_vals[0]);
                let idx_r = _mm_set_epi32(idx_vals[3], idx_vals[2], idx_vals[1], idx_vals[0]);
                let b_r = _mm_set1_epi32(b_vals[0]);
                let _ = _mm_maskz_permutex2var_epi32(k, a_r, idx_r, b_r);
            }
        }
    }

    Ok(())
}
