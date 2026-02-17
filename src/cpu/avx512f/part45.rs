use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, get_random_float32_array, get_random_float64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask_max_sd() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_pd();
        let a = _mm_set_sd(10.0);
        let b = _mm_set_sd(5.0);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_mask_max_sd(src, k, a, b);
        let result_f64 = _mm_cvtsd_f64(result_v);
        check_float_array_equality(&[result_f64], &[10.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let src = _mm_setzero_pd();
                let a = _mm_set_sd(vals[0]);
                let b = _mm_set_sd(vals[1]);
                let k: __mmask8 = 255u8 as __mmask8;
                let _ = _mm_mask_max_sd(src, k, a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_max_sd() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255u8 as __mmask8;
        let a = _mm_set_sd(10.0);
        let b = _mm_set_sd(5.0);
        let result_v = _mm_maskz_max_sd(k, a, b);
        let result_f64 = _mm_cvtsd_f64(result_v);
        check_float_array_equality(&[result_f64], &[10.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let k: __mmask8 = 255u8 as __mmask8;
                let a = _mm_set_sd(vals[0]);
                let b = _mm_set_sd(vals[1]);
                let _ = _mm_maskz_max_sd(k, a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_min_ss() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_ps();
        let a = _mm_set_ss(3.0);
        let b = _mm_set_ss(5.0);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_mask_min_ss(src, k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&result, &[3.0, 0.0, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v1 = get_random_float32_array::<4>();
                let v2 = get_random_float32_array::<4>();
                let src = _mm_setzero_ps();
                let a = _mm_set_ss(v1[0]);
                let b = _mm_set_ss(v2[0]);
                let k: __mmask8 = 255u8 as __mmask8;
                let _ = _mm_mask_min_ss(src, k, a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_min_ss() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255u8 as __mmask8;
        let a = _mm_set_ss(3.0);
        let b = _mm_set_ss(5.0);
        let result_v = _mm_maskz_min_ss(k, a, b);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&result, &[3.0, 0.0, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_float32_array::<4>();
                let k: __mmask8 = 255u8 as __mmask8;
                let a = _mm_set_ss(v[0]);
                let b = _mm_set_ss(v[1]);
                let _ = _mm_maskz_min_ss(k, a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_min_sd() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_pd();
        let a = _mm_set_sd(3.0);
        let b = _mm_set_sd(5.0);
        let k: __mmask8 = 255u8 as __mmask8;
        let result_v = _mm_mask_min_sd(src, k, a, b);
        let result_f64 = _mm_cvtsd_f64(result_v);
        check_float_array_equality(&[result_f64], &[3.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let src = _mm_setzero_pd();
                let a = _mm_set_sd(vals[0]);
                let b = _mm_set_sd(vals[1]);
                let k: __mmask8 = 255u8 as __mmask8;
                let _ = _mm_mask_min_sd(src, k, a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_min_sd() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255u8 as __mmask8;
        let a = _mm_set_sd(3.0);
        let b = _mm_set_sd(5.0);
        let result_v = _mm_maskz_min_sd(k, a, b);
        let result_f64 = _mm_cvtsd_f64(result_v);
        check_float_array_equality(&[result_f64], &[3.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let k: __mmask8 = 255u8 as __mmask8;
                let a = _mm_set_sd(vals[0]);
                let b = _mm_set_sd(vals[1]);
                let _ = _mm_maskz_min_sd(k, a, b);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_sqrt_ss() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_ps();
        let a = _mm_set_ss(9.0);
        let k: __mmask8 = 255u8 as __mmask8;
        // signature: _mm_mask_sqrt_ss(src: __m128, k: __mmask8, a: __m128, b: __m128)
        let result_v = _mm_mask_sqrt_ss(src, k, a, a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&result, &[3.0, 0.0, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_float32_array::<4>();
                let src = _mm_setzero_ps();
                let a = _mm_set_ss(v[0]);
                let k: __mmask8 = 255u8 as __mmask8;
                let _ = _mm_mask_sqrt_ss(src, k, a, a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_sqrt_ss() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255u8 as __mmask8;
        let a = _mm_set_ss(9.0);
        // signature: _mm_maskz_sqrt_ss(k: __mmask8, a: __m128, b: __m128)
        let result_v = _mm_maskz_sqrt_ss(k, a, a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&result, &[3.0, 0.0, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_float32_array::<4>();
                let k: __mmask8 = 255u8 as __mmask8;
                let a = _mm_set_ss(v[0]);
                let _ = _mm_maskz_sqrt_ss(k, a, a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_sqrt_sd() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_pd();
        let a = _mm_set_sd(9.0);
        let k: __mmask8 = 255u8 as __mmask8;
        // signature: _mm_mask_sqrt_sd(src: __m128d, k: __mmask8, a: __m128d, b: __m128d)
        let result_v = _mm_mask_sqrt_sd(src, k, a, a);
        let result_f64 = _mm_cvtsd_f64(result_v);
        check_float_array_equality(&[result_f64], &[3.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let src = _mm_setzero_pd();
                let a = _mm_set_sd(vals[0]);
                let k: __mmask8 = 255u8 as __mmask8;
                let _ = _mm_mask_sqrt_sd(src, k, a, a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_sqrt_sd() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255u8 as __mmask8;
        let a = _mm_set_sd(9.0);
        // signature: _mm_maskz_sqrt_sd(k: __mmask8, a: __m128d, b: __m128d)
        let result_v = _mm_maskz_sqrt_sd(k, a, a);
        let result_f64 = _mm_cvtsd_f64(result_v);
        check_float_array_equality(&[result_f64], &[3.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let k: __mmask8 = 255u8 as __mmask8;
                let a = _mm_set_sd(vals[0]);
                let _ = _mm_maskz_sqrt_sd(k, a, a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_rsqrt14_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(4.0);
        // signature: _mm_rsqrt14_ss(a: __m128, b: __m128)
        let r = _mm_rsqrt14_ss(a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[0.5, 0.0, 0.0, 0.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let v = get_random_float32_array::<4>();
                let a = _mm_set_ss(v[0]);
                let _ = _mm_rsqrt14_ss(a, a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_rsqrt14_ss() -> Result<(), String> {
    test_mm_rsqrt14_ss()
}

pub(super) fn test_mm_maskz_rsqrt14_ss() -> Result<(), String> {
    test_mm_rsqrt14_ss()
}

pub(super) fn test_mm_rsqrt14_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(4.0);
        // signature: _mm_rsqrt14_sd(a: __m128d, b: __m128d)
        let r = _mm_rsqrt14_sd(a, a);
        let result_f64 = _mm_cvtsd_f64(r);
        check_float_array_equality(&[result_f64], &[0.5])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let _ = _mm_rsqrt14_sd(a, a);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_rsqrt14_sd() -> Result<(), String> {
    test_mm_rsqrt14_sd()
}
