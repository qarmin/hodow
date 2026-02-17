use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, get_random_float32_array, get_random_float64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_min_round_sd() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255;
        let a = _mm_set_sd(3.0);
        let b = _mm_set_sd(5.0);
        let r = _mm_maskz_min_round_sd::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(k, a, b);
        let result_f64 = _mm_cvtsd_f64(r);
        check_float_array_equality(&[result_f64], &[3.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<2>();
                let k: __mmask8 = 255;
                let a = _mm_set_sd(vals[0]);
                let b = _mm_set_sd(vals[1]);
                let _ = _mm_maskz_min_round_sd::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(k, a, b);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sqrt_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(9.0);
        // intrinsic signature: _mm_sqrt_round_ss<const ROUNDING>(a: __m128, b: __m128)
        // use the same value for both operands to get deterministic result
        let r = _mm_sqrt_round_ss::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[3.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = get_random_float32_array::<4>();
                let a = _mm_set_ss(v[0]);
                let _ = _mm_sqrt_round_ss::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_sqrt_round_ss() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_ps();
        let a = _mm_set_ss(9.0);
        let k: __mmask8 = 255;
        // signature: _mm_mask_sqrt_round_ss<const ROUNDING>(src: __m128, k: __mmask8, a: __m128, b: __m128)
        let result_v = _mm_mask_sqrt_round_ss::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(src, k, a, a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&result, &[3.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = get_random_float32_array::<4>();
                let src = _mm_setzero_ps();
                let a = _mm_set_ss(v[0]);
                let k: __mmask8 = 255;
                let _ = _mm_mask_sqrt_round_ss::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(src, k, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_sqrt_round_ss() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255;
        let a = _mm_set_ss(9.0);
        // signature: _mm_maskz_sqrt_round_ss<const ROUNDING>(k: __mmask8, a: __m128, b: __m128)
        let result_v = _mm_maskz_sqrt_round_ss::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(k, a, a);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&result, &[3.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = get_random_float32_array::<4>();
                let k: __mmask8 = 255;
                let a = _mm_set_ss(v[0]);
                let _ = _mm_maskz_sqrt_round_ss::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(k, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_sqrt_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(9.0);
        // signature: _mm_sqrt_round_sd<const ROUNDING>(a: __m128d, b: __m128d) -> __m128d
        let r = _mm_sqrt_round_sd::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(a, a);
        let result_f64 = _mm_cvtsd_f64(r);
        check_float_array_equality(&[result_f64], &[3.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let _ = _mm_sqrt_round_sd::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_sqrt_round_sd() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_pd();
        let a = _mm_set_sd(9.0);
        let k: __mmask8 = 255;
        // signature: _mm_mask_sqrt_round_sd<const ROUNDING>(src: __m128d, k: __mmask8, a: __m128d, b: __m128d)
        let result_v = _mm_mask_sqrt_round_sd::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(src, k, a, a);
        let result_f64 = _mm_cvtsd_f64(result_v);
        check_float_array_equality(&[result_f64], &[3.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<2>();
                let src = _mm_setzero_pd();
                let a = _mm_set_sd(vals[0]);
                let k: __mmask8 = 255;
                let _ = _mm_mask_sqrt_round_sd::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(src, k, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_sqrt_round_sd() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255;
        let a = _mm_set_sd(9.0);
        // signature: _mm_maskz_sqrt_round_sd<const ROUNDING>(k: __mmask8, a: __m128d, b: __m128d)
        let result_v = _mm_maskz_sqrt_round_sd::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(k, a, a);
        let result_f64 = _mm_cvtsd_f64(result_v);
        check_float_array_equality(&[result_f64], &[3.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<2>();
                let k: __mmask8 = 255;
                let a = _mm_set_sd(vals[0]);
                let _ = _mm_maskz_sqrt_round_sd::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(k, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_getexp_round_ss() -> Result<(), String> {
    unsafe {
        // deterministic placeholder check to keep test stable across archs
        let a = _mm_set_ss(1.5);
        // signature: _mm_getexp_round_ss<const SAE>(a: __m128, b: __m128) -> __m128
        let r = _mm_getexp_round_ss::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[0.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = get_random_float32_array::<4>();
                let a = _mm_set_ss(v[0]);
                let _ = _mm_getexp_round_ss::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_getexp_round_ss() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_ps();
        let a = _mm_set_ss(1.5);
        let k: __mmask8 = 255;
        // signature: _mm_mask_getexp_round_ss<const SAE>(src: __m128, k: __mmask8, a: __m128, b: __m128)
        let r = _mm_mask_getexp_round_ss::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(src, k, a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[0.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = get_random_float32_array::<4>();
                let src = _mm_setzero_ps();
                let a = _mm_set_ss(v[0]);
                let k: __mmask8 = 255;
                let _ = _mm_mask_getexp_round_ss::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(src, k, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_getexp_round_ss() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255;
        let a = _mm_set_ss(1.5);
        // signature: _mm_maskz_getexp_round_ss<const SAE>(k: __mmask8, a: __m128, b: __m128)
        let r = _mm_maskz_getexp_round_ss::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(k, a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[0.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = get_random_float32_array::<4>();
                let k: __mmask8 = 255;
                let a = _mm_set_ss(v[0]);
                let _ = _mm_maskz_getexp_round_ss::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(k, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_getexp_round_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.5);
        // signature: _mm_getexp_round_sd<const SAE>(a: __m128d, b: __m128d) -> __m128d
        let r = _mm_getexp_round_sd::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(a, a);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<2>();
                let a = _mm_set_sd(vals[0]);
                let _ = _mm_getexp_round_sd::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_getexp_round_sd() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_pd();
        let a = _mm_set_sd(1.5);
        let k: __mmask8 = 255;
        // signature: _mm_mask_getexp_round_sd<const SAE>(src: __m128d, k: __mmask8, a: __m128d, b: __m128d)
        let r = _mm_mask_getexp_round_sd::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(src, k, a, a);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<2>();
                let src = _mm_setzero_pd();
                let a = _mm_set_sd(vals[0]);
                let k: __mmask8 = 255;
                let _ = _mm_mask_getexp_round_sd::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(src, k, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_getexp_round_sd() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255;
        let a = _mm_set_sd(1.5);
        // signature: _mm_maskz_getexp_round_sd<const SAE>(k: __mmask8, a: __m128d, b: __m128d)
        let r = _mm_maskz_getexp_round_sd::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(k, a, a);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(r);
        check_float_array_equality(&out, &[0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let vals = get_random_float64_array::<2>();
                let k: __mmask8 = 255;
                let a = _mm_set_sd(vals[0]);
                let _ = _mm_maskz_getexp_round_sd::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }>(k, a, a);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_getmant_round_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.5);
        let r = _mm_getmant_round_ss::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }, 0, 0>(a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let _ = _mm_getmant_round_ss::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }, 0, 0>(a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_getmant_round_ss() -> Result<(), String> {
    unsafe {
        let src = _mm_setzero_ps();
        let a = _mm_set_ss(1.5);
        let k: __mmask8 = 255;
        let r = _mm_mask_getmant_round_ss::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }, 0, 0>(src, k, a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0, 0.0, 0.0, 0.0])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<1>();
                let src = _mm_setzero_ps();
                let a_r = _mm_set_ss(ra[0]);
                let k: __mmask8 = 255;
                let _ = _mm_mask_getmant_round_ss::<{ _MM_FROUND_TO_NEAREST_INT | _MM_FROUND_NO_EXC }, 0, 0>(src, k, a_r, a_r);
            }
        }
    }
    Ok(())
}
