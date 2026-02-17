use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, check_float_equality, get_random_float32_array, get_random_float64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_getmant_ss() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 255;
        let a = _mm_set_ss(-3.5f32);
        let r = _mm_maskz_getmant_ss::<0, 0>(k, a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[0.0f32, 0.0f32, 0.0f32, 0.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(v[0]);
                let _ = _mm_maskz_getmant_ss::<0, 0>(k, a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_getmant_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(-5.25f64);
        let r = _mm_getmant_sd::<0, 0>(a, a);
        let result_f64 = _mm_cvtsd_f64(r);
        check_float_equality(result_f64, 0.0)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(v[0]);
                let _ = _mm_getmant_sd::<0, 0>(a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_getmant_sd() -> Result<(), String> {
    unsafe {
        let src = _mm_set_sd(1.0);
        let k: __mmask8 = 0;
        let a = _mm_set_sd(-2.0);
        let r = _mm_mask_getmant_sd::<0, 0>(src, k, a, a);
        let result_f64 = _mm_cvtsd_f64(r);
        check_float_equality(result_f64, 1.0)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let src_v = get_random_float64_array::<1>();
                let a_v = get_random_float64_array::<1>();
                let src_r = _mm_set_sd(src_v[0]);
                let a_r = _mm_set_sd(a_v[0]);
                let _ = _mm_mask_getmant_sd::<0, 0>(src_r, 255, a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_getmant_sd() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 0;
        let a = _mm_set_sd(-2.5);
        let r = _mm_maskz_getmant_sd::<0, 0>(k, a, a);
        let result_f64 = _mm_cvtsd_f64(r);
        check_float_equality(result_f64, 0.0)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(v[0]);
                let _ = _mm_maskz_getmant_sd::<0, 0>(255, a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_roundscale_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(1.5f32);
        let r = _mm_roundscale_ss::<1>(a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[3.0f32, 0.0f32, 0.0f32, 0.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(v[0]);
                let _ = _mm_roundscale_ss::<1>(a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_roundscale_ss() -> Result<(), String> {
    unsafe {
        let src = _mm_set_ss(2.0f32);
        let k: __mmask8 = 0;
        let a = _mm_set_ss(1.5f32);
        let r = _mm_mask_roundscale_ss::<2>(src, k, a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[2.0f32, 0.0f32, 0.0f32, 0.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let src_v = get_random_float32_array::<1>();
                let a_v = get_random_float32_array::<1>();
                let src_r = _mm_set_ss(src_v[0]);
                let a_r = _mm_set_ss(a_v[0]);
                let _ = _mm_mask_roundscale_ss::<1>(src_r, 255, a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_roundscale_ss() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 0;
        let a = _mm_set_ss(1.25f32);
        let r = _mm_maskz_roundscale_ss::<2>(k, a, a);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[0.0f32, 0.0f32, 0.0f32, 0.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(v[0]);
                let _ = _mm_maskz_roundscale_ss::<1>(255, a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_roundscale_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(1.5f64);
        let r = _mm_roundscale_sd::<2>(a, a);
        let result_f64 = _mm_cvtsd_f64(r);
        check_float_equality(result_f64, 6.0)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(v[0]);
                let _ = _mm_roundscale_sd::<1>(a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_roundscale_sd() -> Result<(), String> {
    unsafe {
        let src = _mm_set_sd(3.0f64);
        let k: __mmask8 = 0;
        let a = _mm_set_sd(1.5f64);
        let r = _mm_mask_roundscale_sd::<1>(src, k, a, a);
        let result_f64 = _mm_cvtsd_f64(r);
        check_float_equality(result_f64, 3.0)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let src_v = get_random_float64_array::<1>();
                let a_v = get_random_float64_array::<1>();
                let src_r = _mm_set_sd(src_v[0]);
                let a_r = _mm_set_sd(a_v[0]);
                let _ = _mm_mask_roundscale_sd::<1>(src_r, 255, a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_roundscale_sd() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 0;
        let a = _mm_set_sd(2.25f64);
        let r = _mm_maskz_roundscale_sd::<1>(k, a, a);
        let result_f64 = _mm_cvtsd_f64(r);
        check_float_equality(result_f64, 0.0)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let v = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(v[0]);
                let _ = _mm_maskz_roundscale_sd::<1>(255, a_r, a_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_scalef_ss() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ss(2.0f32);
        let b = _mm_set_ss(3.5f32);
        let r = _mm_scalef_ss(a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[7.0f32, 0.0f32, 0.0f32, 0.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float32_array::<1>();
                let rb = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(ra[0]);
                let b_r = _mm_set_ss(rb[0]);
                let _ = _mm_scalef_ss(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_scalef_ss() -> Result<(), String> {
    unsafe {
        let src = _mm_set_ss(4.0f32);
        let k: __mmask8 = 0;
        let a = _mm_set_ss(2.0f32);
        let b = _mm_set_ss(3.0f32);
        let r = _mm_mask_scalef_ss(src, k, a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[4.0f32, 0.0f32, 0.0f32, 0.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let src_v = get_random_float32_array::<1>();
                let a_v = get_random_float32_array::<1>();
                let b_v = get_random_float32_array::<1>();
                let src_r = _mm_set_ss(src_v[0]);
                let a_r = _mm_set_ss(a_v[0]);
                let b_r = _mm_set_ss(b_v[0]);
                let _ = _mm_mask_scalef_ss(src_r, 255, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_scalef_ss() -> Result<(), String> {
    unsafe {
        let k: __mmask8 = 0;
        let a = _mm_set_ss(2.0f32);
        let b = _mm_set_ss(3.0f32);
        let r = _mm_maskz_scalef_ss(k, a, b);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(r);
        check_float_array_equality(&out, &[0.0f32, 0.0f32, 0.0f32, 0.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let a_v = get_random_float32_array::<1>();
                let b_v = get_random_float32_array::<1>();
                let a_r = _mm_set_ss(a_v[0]);
                let b_r = _mm_set_ss(b_v[0]);
                let _ = _mm_maskz_scalef_ss(255, a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_scalef_sd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_sd(2.0f64);
        let b = _mm_set_sd(3.5f64);
        let r = _mm_scalef_sd(a, b);
        let result_f64 = _mm_cvtsd_f64(r);
        check_float_equality(result_f64, 7.0)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let ra = get_random_float64_array::<1>();
                let rb = get_random_float64_array::<1>();
                let a_r = _mm_set_sd(ra[0]);
                let b_r = _mm_set_sd(rb[0]);
                let _ = _mm_scalef_sd(a_r, b_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_scalef_sd() -> Result<(), String> {
    unsafe {
        let src = _mm_set_sd(5.0f64);
        let k: __mmask8 = 0;
        let a = _mm_set_sd(2.0f64);
        let b = _mm_set_sd(3.0f64);
        let r = _mm_mask_scalef_sd(src, k, a, b);
        let result_f64 = _mm_cvtsd_f64(r);
        check_float_equality(result_f64, 5.0)?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let src_v = get_random_float64_array::<1>();
                let a_v = get_random_float64_array::<1>();
                let b_v = get_random_float64_array::<1>();
                let src_r = _mm_set_sd(src_v[0]);
                let a_r = _mm_set_sd(a_v[0]);
                let b_r = _mm_set_sd(b_v[0]);
                let _ = _mm_mask_scalef_sd(src_r, 255, a_r, b_r);
            }
        }
    }
    Ok(())
}
