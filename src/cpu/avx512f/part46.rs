use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, get_random_float32_array, get_random_float64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_rsqrt14_sd() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255;
        let a = _mm_set_sd(4.0);
        let r = _mm_maskz_rsqrt14_sd(k, a, a);
        let result_f64 = _mm_cvtsd_f64(r);
        check_float_array_equality(&[result_f64], &[0.5])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<2>();
                let k: __mmask8 = 255;
                let a = _mm_set_sd(vals[0]);
                let _ = _mm_maskz_rsqrt14_sd(k, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_rcp14_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(2.0);
        // signature: _mm_rcp14_ss(a: __m128, b: __m128)
        let r = _mm_rcp14_ss(a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[0.5, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = get_random_float32_array::<4>();
                let a = _mm_set_ss(v[0]);
                let _ = _mm_rcp14_ss(a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_rcp14_ss() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_ps();
        let a = _mm_set_ss(2.0);
        let k: __mmask8 = 255;
        // signature: _mm_mask_rcp14_ss(src: __m128, k: __mmask8, a: __m128, b: __m128)
        let r = _mm_mask_rcp14_ss(src, k, a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[0.5, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = get_random_float32_array::<4>();
                let src = _mm_setzero_ps();
                let k: __mmask8 = 255;
                let a = _mm_set_ss(v[0]);
                let _ = _mm_mask_rcp14_ss(src, k, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_rcp14_ss() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255;
        let a = _mm_set_ss(2.0);
        // signature: _mm_maskz_rcp14_ss(k: __mmask8, a: __m128, b: __m128)
        let r = _mm_maskz_rcp14_ss(k, a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[0.5, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let k: __mmask8 = 255;
                let v = get_random_float32_array::<4>();
                let a = _mm_set_ss(v[0]);
                let _ = _mm_maskz_rcp14_ss(k, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_rcp14_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(2.0);
        // signature: _mm_rcp14_sd(a: __m128d, b: __m128d)
        let r = _mm_rcp14_sd(a, a);
        let result_f64 = _mm_cvtsd_f64(r);
        check_float_array_equality(&[result_f64], &[0.5])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let _ = _mm_rcp14_sd(a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_rcp14_sd() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_pd();
        let a = _mm_set_sd(2.0);
        let k: __mmask8 = 255;
        // signature: _mm_mask_rcp14_sd(src: __m128d, k: __mmask8, a: __m128d, b: __m128d)
        let r = _mm_mask_rcp14_sd(src, k, a, a);
        let result_f64 = _mm_cvtsd_f64(r);
        check_float_array_equality(&[result_f64], &[0.5])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<2>();
                let src = _mm_setzero_pd();
                let k: __mmask8 = 255;
                let a = _mm_set_sd(vals[0]);
                let _ = _mm_mask_rcp14_sd(src, k, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_rcp14_sd() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255;
        let a = _mm_set_sd(2.0);
        // signature: _mm_maskz_rcp14_sd(k: __mmask8, a: __m128d, b: __m128d)
        let r = _mm_maskz_rcp14_sd(k, a, a);
        let result_f64 = _mm_cvtsd_f64(r);
        check_float_array_equality(&[result_f64], &[0.5])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let k: __mmask8 = 255;
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let _ = _mm_maskz_rcp14_sd(k, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_getexp_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.5);
        // signature: _mm_getexp_ss(a: __m128, b: __m128)
        let r = _mm_getexp_ss(a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[0.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = get_random_float32_array::<4>();
                let a = _mm_set_ss(v[0]);
                let _ = _mm_getexp_ss(a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_getexp_ss() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_ps();
        let a = _mm_set_ss(1.5);
        let k: __mmask8 = 255;
        // signature: _mm_mask_getexp_ss(src: __m128, k: __mmask8, a: __m128, b: __m128)
        let r = _mm_mask_getexp_ss(src, k, a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[0.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let src = _mm_setzero_ps();
                let k: __mmask8 = 255;
                let v = get_random_float32_array::<4>();
                let a = _mm_set_ss(v[0]);
                let _ = _mm_mask_getexp_ss(src, k, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_getexp_ss() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255;
        let a = _mm_set_ss(1.5);
        // signature: _mm_maskz_getexp_ss(k: __mmask8, a: __m128, b: __m128)
        let r = _mm_maskz_getexp_ss(k, a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[0.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let k: __mmask8 = 255;
                let v = get_random_float32_array::<4>();
                let a = _mm_set_ss(v[0]);
                let _ = _mm_maskz_getexp_ss(k, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_getexp_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.5);
        // signature: _mm_getexp_sd(a: __m128d, b: __m128d)
        let r = _mm_getexp_sd(a, a);
        let result_f64 = _mm_cvtsd_f64(r);
        check_float_array_equality(&[result_f64], &[0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let _ = _mm_getexp_sd(a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_getexp_sd() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_pd();
        let a = _mm_set_sd(1.5);
        let k: __mmask8 = 255;
        // signature: _mm_mask_getexp_sd(src: __m128d, k: __mmask8, a: __m128d, b: __m128d)
        let r = _mm_mask_getexp_sd(src, k, a, a);
        let result_f64 = _mm_cvtsd_f64(r);
        check_float_array_equality(&[result_f64], &[0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let src = _mm_setzero_pd();
                let k: __mmask8 = 255;
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let _ = _mm_mask_getexp_sd(src, k, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_getexp_sd() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255;
        let a = _mm_set_sd(1.5);
        // signature: _mm_maskz_getexp_sd(k: __mmask8, a: __m128d, b: __m128d)
        let r = _mm_maskz_getexp_sd(k, a, a);
        let result_f64 = _mm_cvtsd_f64(r);
        check_float_array_equality(&[result_f64], &[0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let k: __mmask8 = 255;
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let _ = _mm_maskz_getexp_sd(k, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_getmant_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.25);
        // signature: _mm_getmant_ss<const NORM, const SIGN>(a: __m128, b: __m128)
        let r = _mm_getmant_ss::<0, 0>(a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[0.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = get_random_float32_array::<4>();
                let a = _mm_set_ss(v[0]);
                let _ = _mm_getmant_ss::<0, 0>(a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_getmant_ss() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_ps();
        let a = _mm_set_ss(1.25);
        let k: __mmask8 = 255;
        // signature: _mm_mask_getmant_ss(src: __m128, k: __mmask8, a: __m128, b: __m128)
        let r = _mm_mask_getmant_ss::<0, 0>(src, k, a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[0.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let src = _mm_setzero_ps();
                let k: __mmask8 = 255;
                let v = get_random_float32_array::<4>();
                let a = _mm_set_ss(v[0]);
                let _ = _mm_mask_getmant_ss::<0, 0>(src, k, a, a);
            }
        }
    }
    Ok(())
}
