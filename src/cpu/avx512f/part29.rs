use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality, get_random_float32_array, get_random_float64_array, get_random_i32_array, get_random_i64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask2_permutex2var_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi32(1);
        let idx = _mm_set_epi32(3, 2, 1, 0);
        let b = _mm_set1_epi32(2);
        let k: __mmask8 = 255;
        let result = _mm_mask2_permutex2var_epi32(a, idx, k, b);
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
                let _ = _mm_mask2_permutex2var_epi32(a_r, idx_r, k, b_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_permutex2var_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1);
        let idx = _mm_set_epi64x(1, 0);
        let result = _mm_permutex2var_epi64(a, idx, a);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&out, &[1, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a_vals = get_random_i64_array::<1>();
                let idx_vals = get_random_i32_array::<2>();
                let a_r = _mm_set1_epi64x(a_vals[0]);
                let idx_r = _mm_set_epi64x(idx_vals[1] as i64, idx_vals[0] as i64);
                let _ = _mm_permutex2var_epi64(a_r, idx_r, a_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_permutex2var_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1);
        let idx = _mm_set_epi64x(1, 0);
        let b = _mm_set1_epi64x(2);
        let k: __mmask8 = 255;
        let result = _mm_mask_permutex2var_epi64(a, k, idx, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&out, &[1, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a_vals = get_random_i64_array::<1>();
                let idx_vals = get_random_i32_array::<2>();
                let b_vals = get_random_i64_array::<1>();
                let a_r = _mm_set1_epi64x(a_vals[0]);
                let idx_r = _mm_set_epi64x(idx_vals[1] as i64, idx_vals[0] as i64);
                let b_r = _mm_set1_epi64x(b_vals[0]);
                let _ = _mm_mask_permutex2var_epi64(a_r, k, idx_r, b_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_permutex2var_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1);
        let idx = _mm_set_epi64x(1, 0);
        let b = _mm_set1_epi64x(2);
        let k: __mmask8 = 255;
        let result = _mm_maskz_permutex2var_epi64(k, a, idx, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&out, &[1, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a_vals = get_random_i64_array::<1>();
                let idx_vals = get_random_i32_array::<2>();
                let b_vals = get_random_i64_array::<1>();
                let a_r = _mm_set1_epi64x(a_vals[0]);
                let idx_r = _mm_set_epi64x(idx_vals[1] as i64, idx_vals[0] as i64);
                let b_r = _mm_set1_epi64x(b_vals[0]);
                let _ = _mm_maskz_permutex2var_epi64(k, a_r, idx_r, b_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask2_permutex2var_epi64() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_epi64x(1);
        let idx = _mm_set_epi64x(1, 0);
        let b = _mm_set1_epi64x(2);
        let k: __mmask8 = 255;
        let result = _mm_mask2_permutex2var_epi64(a, idx, k, b);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(result);
        check_array_equality(&out, &[1, 1])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a_vals = get_random_i64_array::<1>();
                let idx_vals = get_random_i32_array::<2>();
                let b_vals = get_random_i64_array::<1>();
                let a_r = _mm_set1_epi64x(a_vals[0]);
                let idx_r = _mm_set_epi64x(idx_vals[1] as i64, idx_vals[0] as i64);
                let b_r = _mm_set1_epi64x(b_vals[0]);
                let _ = _mm_mask2_permutex2var_epi64(a_r, idx_r, k, b_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_permutex2var_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.0);
        let idx = _mm_set_epi32(3, 2, 1, 0);
        let result = _mm_permutex2var_ps(a, idx, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality(&out, &[1.0, 1.0, 1.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let idx_vals = get_random_i32_array::<4>();
                let idx_r = _mm_set_epi32(idx_vals[3], idx_vals[2], idx_vals[1], idx_vals[0]);
                let _ = _mm_permutex2var_ps(a_r, idx_r, a_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_permutex2var_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.0);
        let idx = _mm_set_epi32(3, 2, 1, 0);
        let b = _mm_set1_ps(2.0);
        let k: __mmask8 = 255;
        let result = _mm_mask_permutex2var_ps(a, k, idx, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality(&out, &[1.0, 1.0, 1.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let rb = get_random_float32_array::<1>();
                let idx_vals = get_random_i32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let idx_r = _mm_set_epi32(idx_vals[3], idx_vals[2], idx_vals[1], idx_vals[0]);
                let b_r = _mm_set1_ps(rb[0]);
                let _ = _mm_mask_permutex2var_ps(a_r, k, idx_r, b_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_permutex2var_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.0);
        let idx = _mm_set_epi32(3, 2, 1, 0);
        let b = _mm_set1_ps(2.0);
        let k: __mmask8 = 255;
        let result = _mm_maskz_permutex2var_ps(k, a, idx, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality(&out, &[1.0, 1.0, 1.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let rb = get_random_float32_array::<1>();
                let idx_vals = get_random_i32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let idx_r = _mm_set_epi32(idx_vals[3], idx_vals[2], idx_vals[1], idx_vals[0]);
                let b_r = _mm_set1_ps(rb[0]);
                let _ = _mm_maskz_permutex2var_ps(k, a_r, idx_r, b_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask2_permutex2var_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_ps(1.0);
        let idx = _mm_set_epi32(3, 2, 1, 0);
        let b = _mm_set1_ps(2.0);
        let k: __mmask8 = 255;
        let result = _mm_mask2_permutex2var_ps(a, idx, k, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(result);
        check_float_array_equality(&out, &[1.0, 1.0, 1.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<4>();
                let rb = get_random_float32_array::<1>();
                let idx_vals = get_random_i32_array::<4>();
                let a_r = _mm_set_ps(ra[3], ra[2], ra[1], ra[0]);
                let idx_r = _mm_set_epi32(idx_vals[3], idx_vals[2], idx_vals[1], idx_vals[0]);
                let b_r = _mm_set1_ps(rb[0]);
                let _ = _mm_mask2_permutex2var_ps(a_r, idx_r, k, b_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_permutex2var_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_pd(1.0);
        let idx = _mm_set_epi32(1, 0, 0, 1);
        let result = _mm_permutex2var_pd(a, idx, a);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality(&out, &[1.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let idx_r = _mm_set_epi32(0, 0, 0, 1);
                let _ = _mm_permutex2var_pd(a_r, idx_r, a_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_permutex2var_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_pd(1.0);
        let idx = _mm_set_epi32(1, 0, 0, 1);
        let b = _mm_set1_pd(2.0);
        let k: __mmask8 = 255;
        let result = _mm_mask_permutex2var_pd(a, k, idx, b);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality(&out, &[1.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let rb = get_random_float64_array::<1>();
                let idx_vals = get_random_i32_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let idx_r = _mm_set_epi64x(idx_vals[1] as i64, idx_vals[0] as i64);
                let b_r = _mm_set1_pd(rb[0]);
                let _ = _mm_mask_permutex2var_pd(a_r, k, idx_r, b_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_permutex2var_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_pd(1.0);
        let idx = _mm_set_epi32(1, 0, 0, 1);
        let b = _mm_set1_pd(2.0);
        let k: __mmask8 = 255;
        let result = _mm_maskz_permutex2var_pd(k, a, idx, b);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality(&out, &[1.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let rb = get_random_float64_array::<1>();
                let idx_vals = get_random_i32_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let idx_r = _mm_set_epi64x(idx_vals[1] as i64, idx_vals[0] as i64);
                let b_r = _mm_set1_pd(rb[0]);
                let _ = _mm_maskz_permutex2var_pd(k, a_r, idx_r, b_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask2_permutex2var_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set1_pd(1.0);
        let idx = _mm_set_epi32(1, 0, 0, 1);
        let b = _mm_set1_pd(2.0);
        let k: __mmask8 = 255;
        let result = _mm_mask2_permutex2var_pd(a, idx, k, b);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(result);
        check_float_array_equality(&out, &[1.0, 1.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<2>();
                let rb = get_random_float64_array::<1>();
                let idx_vals = get_random_i32_array::<2>();
                let a_r = _mm_set_pd(ra[1], ra[0]);
                let idx_r = _mm_set_epi64x(idx_vals[1] as i64, idx_vals[0] as i64);
                let b_r = _mm_set1_pd(rb[0]);
                let _ = _mm_mask2_permutex2var_pd(a_r, idx_r, k, b_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_shuffle_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(3, 2, 1, 0);
        let k: __mmask8 = 255;
        let result = _mm_mask_shuffle_epi32::<27>(_mm_setzero_si128(), k, a);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&out, &[3, 2, 1, 0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(vals[3], vals[2], vals[1], vals[0]);
                let _ = _mm_mask_shuffle_epi32::<27>(_mm_setzero_si128(), k, a_r);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_shuffle_epi32() -> Result<(), String> {
    unsafe {
        let a = _mm_set_epi32(3, 2, 1, 0);
        let k: __mmask8 = 255;
        let result = _mm_maskz_shuffle_epi32::<27>(k, a);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(result);
        check_array_equality(&out, &[3, 2, 1, 0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_i32_array::<4>();
                let a_r = _mm_set_epi32(vals[3], vals[2], vals[1], vals[0]);
                let _ = _mm_maskz_shuffle_epi32::<27>(k, a_r);
            }
        }
    }

    Ok(())
}
