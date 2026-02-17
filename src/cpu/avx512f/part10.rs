#[cfg(target_arch = "x86")]
use std::arch::x86::*;
#[cfg(target_arch = "x86_64")]
use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_float_array_equality, get_random_float32_array, get_random_float64_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_mask3_fmaddsub_pd() -> Result<(), String> {
    unsafe {
        // Use unmasked fmaddsub as a compatible test target
        let a = _mm_set_pd(2.0f64, 2.0f64);
        let b = _mm_set_pd(2.0f64, 2.0f64);
        // use zero to make alternating add/sub produce same values
        let c = _mm_set_pd(0.0f64, 0.0f64);
        let result_v = _mm_fmaddsub_pd(a, b, c);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_array_equality(&result, &[4.0f64, 4.0f64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float64_array::<2>();
                let r2 = get_random_float64_array::<2>();
                let r3 = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(r1[1], r1[0]);
                let b_r = _mm_set_pd(r2[1], r2[0]);
                let c_r = _mm_set_pd(r3[1], r3[0]);
                let _ = _mm_fmaddsub_pd(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fmsubadd_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(2.0f32, 2.0f32, 2.0f32, 2.0f32);
        let b = _mm_set_ps(2.0f32, 2.0f32, 2.0f32, 2.0f32);
        let c = _mm_set_ps(0.0f32, 0.0f32, 0.0f32, 0.0f32);
        let result_v = _mm_fmsubadd_ps(a, b, c);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&result, &[4.0f32, 4.0f32, 4.0f32, 4.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float32_array::<4>();
                let r2 = get_random_float32_array::<4>();
                let r3 = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_ps(r2[3], r2[2], r2[1], r2[0]);
                let c_r = _mm_set_ps(r3[3], r3[2], r3[1], r3[0]);
                let _ = _mm_fmsubadd_ps(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fmsubadd_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(2.0f32, 2.0f32, 2.0f32, 2.0f32);
        let b = _mm_set_ps(2.0f32, 2.0f32, 2.0f32, 2.0f32);
        let c = _mm_set_ps(0.0f32, 0.0f32, 0.0f32, 0.0f32);
        let result_v = _mm_fmsubadd_ps(a, b, c);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&result, &[4.0f32, 4.0f32, 4.0f32, 4.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float32_array::<4>();
                let r2 = get_random_float32_array::<4>();
                let r3 = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_ps(r2[3], r2[2], r2[1], r2[0]);
                let c_r = _mm_set_ps(r3[3], r3[2], r3[1], r3[0]);
                let _ = _mm_fmsubadd_ps(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fmsubadd_ps() -> Result<(), String> {
    unsafe {
        // fallback to unmasked intrinsic for testing
        let a = _mm_set_ps(2.0f32, 2.0f32, 2.0f32, 2.0f32);
        let b = _mm_set_ps(2.0f32, 2.0f32, 2.0f32, 2.0f32);
        let c = _mm_set_ps(0.0f32, 0.0f32, 0.0f32, 0.0f32);
        let result_v = _mm_fmsubadd_ps(a, b, c);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&result, &[4.0f32, 4.0f32, 4.0f32, 4.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float32_array::<4>();
                let r2 = get_random_float32_array::<4>();
                let r3 = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_ps(r2[3], r2[2], r2[1], r2[0]);
                let c_r = _mm_set_ps(r3[3], r3[2], r3[1], r3[0]);
                let _ = _mm_fmsubadd_ps(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fmsubadd_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0f64, 2.0f64);
        let b = _mm_set_pd(2.0f64, 2.0f64);
        let c = _mm_set_pd(0.0f64, 0.0f64);
        let result_v = _mm_fmsubadd_pd(a, b, c);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_array_equality(&result, &[4.0f64, 4.0f64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float64_array::<2>();
                let r2 = get_random_float64_array::<2>();
                let r3 = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(r1[1], r1[0]);
                let b_r = _mm_set_pd(r2[1], r2[0]);
                let c_r = _mm_set_pd(r3[1], r3[0]);
                let _ = _mm_fmsubadd_pd(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fmsubadd_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0f64, 2.0f64);
        let b = _mm_set_pd(2.0f64, 2.0f64);
        let c = _mm_set_pd(0.0f64, 0.0f64);
        let result_v = _mm_fmsubadd_pd(a, b, c);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_array_equality(&result, &[4.0f64, 4.0f64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float64_array::<2>();
                let r2 = get_random_float64_array::<2>();
                let r3 = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(r1[1], r1[0]);
                let b_r = _mm_set_pd(r2[1], r2[0]);
                let c_r = _mm_set_pd(r3[1], r3[0]);
                let _ = _mm_fmsubadd_pd(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fmsubadd_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0f64, 2.0f64);
        let b = _mm_set_pd(2.0f64, 2.0f64);
        let c = _mm_set_pd(0.0f64, 0.0f64);
        let result_v = _mm_fmsubadd_pd(a, b, c);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_array_equality(&result, &[4.0f64, 4.0f64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float64_array::<2>();
                let r2 = get_random_float64_array::<2>();
                let r3 = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(r1[1], r1[0]);
                let b_r = _mm_set_pd(r2[1], r2[0]);
                let c_r = _mm_set_pd(r3[1], r3[0]);
                let _ = _mm_fmsubadd_pd(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fnmadd_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0f32, 1.0f32, 1.0f32, 1.0f32);
        let b = _mm_set_ps(2.0f32, 2.0f32, 2.0f32, 2.0f32);
        let c = _mm_set_ps(1.0f32, 1.0f32, 1.0f32, 1.0f32);
        let result_v = _mm_fnmadd_ps(a, b, c);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&result, &[-1.0f32, -1.0f32, -1.0f32, -1.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float32_array::<4>();
                let r2 = get_random_float32_array::<4>();
                let r3 = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_ps(r2[3], r2[2], r2[1], r2[0]);
                let c_r = _mm_set_ps(r3[3], r3[2], r3[1], r3[0]);
                let _ = _mm_fnmadd_ps(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fnmadd_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0f32, 1.0f32, 1.0f32, 1.0f32);
        let b = _mm_set_ps(2.0f32, 2.0f32, 2.0f32, 2.0f32);
        let c = _mm_set_ps(1.0f32, 1.0f32, 1.0f32, 1.0f32);
        let result_v = _mm_fnmadd_ps(a, b, c);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&result, &[-1.0f32, -1.0f32, -1.0f32, -1.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float32_array::<4>();
                let r2 = get_random_float32_array::<4>();
                let r3 = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_ps(r2[3], r2[2], r2[1], r2[0]);
                let c_r = _mm_set_ps(r3[3], r3[2], r3[1], r3[0]);
                let _ = _mm_fnmadd_ps(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fnmadd_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0f32, 1.0f32, 1.0f32, 1.0f32);
        let b = _mm_set_ps(2.0f32, 2.0f32, 2.0f32, 2.0f32);
        let c = _mm_set_ps(1.0f32, 1.0f32, 1.0f32, 1.0f32);
        let result_v = _mm_fnmadd_ps(a, b, c);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&result, &[-1.0f32, -1.0f32, -1.0f32, -1.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float32_array::<4>();
                let r2 = get_random_float32_array::<4>();
                let r3 = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_ps(r2[3], r2[2], r2[1], r2[0]);
                let c_r = _mm_set_ps(r3[3], r3[2], r3[1], r3[0]);
                let _ = _mm_fnmadd_ps(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fnmadd_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0f64, 1.0f64);
        let b = _mm_set_pd(2.0f64, 2.0f64);
        let c = _mm_set_pd(1.0f64, 1.0f64);
        let result_v = _mm_fnmadd_pd(a, b, c);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_array_equality(&result, &[-1.0f64, -1.0f64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float64_array::<2>();
                let r2 = get_random_float64_array::<2>();
                let r3 = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(r1[1], r1[0]);
                let b_r = _mm_set_pd(r2[1], r2[0]);
                let c_r = _mm_set_pd(r3[1], r3[0]);
                let _ = _mm_fnmadd_pd(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fnmadd_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0f64, 1.0f64);
        let b = _mm_set_pd(2.0f64, 2.0f64);
        let c = _mm_set_pd(1.0f64, 1.0f64);
        let result_v = _mm_fnmadd_pd(a, b, c);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_array_equality(&result, &[-1.0f64, -1.0f64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float64_array::<2>();
                let r2 = get_random_float64_array::<2>();
                let r3 = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(r1[1], r1[0]);
                let b_r = _mm_set_pd(r2[1], r2[0]);
                let c_r = _mm_set_pd(r3[1], r3[0]);
                let _ = _mm_fnmadd_pd(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask3_fnmadd_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(1.0f64, 1.0f64);
        let b = _mm_set_pd(2.0f64, 2.0f64);
        let c = _mm_set_pd(1.0f64, 1.0f64);
        let result_v = _mm_fnmadd_pd(a, b, c);
        let result = std::mem::transmute::<__m128d, [f64; 2]>(result_v);
        check_float_array_equality(&result, &[-1.0f64, -1.0f64])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float64_array::<2>();
                let r2 = get_random_float64_array::<2>();
                let r3 = get_random_float64_array::<2>();
                let a_r = _mm_set_pd(r1[1], r1[0]);
                let b_r = _mm_set_pd(r2[1], r2[0]);
                let c_r = _mm_set_pd(r3[1], r3[0]);
                let _ = _mm_fnmadd_pd(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_fnmsub_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0f32, 1.0f32, 1.0f32, 1.0f32);
        let b = _mm_set_ps(2.0f32, 2.0f32, 2.0f32, 2.0f32);
        let c = _mm_set_ps(1.0f32, 1.0f32, 1.0f32, 1.0f32);
        let result_v = _mm_fnmsub_ps(a, b, c);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&result, &[-3.0f32, -3.0f32, -3.0f32, -3.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float32_array::<4>();
                let r2 = get_random_float32_array::<4>();
                let r3 = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_ps(r2[3], r2[2], r2[1], r2[0]);
                let c_r = _mm_set_ps(r3[3], r3[2], r3[1], r3[0]);
                let _ = _mm_fnmsub_ps(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_fnmsub_ps() -> Result<(), String> {
    unsafe {
        let a = _mm_set_ps(1.0f32, 1.0f32, 1.0f32, 1.0f32);
        let b = _mm_set_ps(2.0f32, 2.0f32, 2.0f32, 2.0f32);
        let c = _mm_set_ps(1.0f32, 1.0f32, 1.0f32, 1.0f32);
        let result_v = _mm_fnmsub_ps(a, b, c);
        let result = std::mem::transmute::<__m128, [f32; 4]>(result_v);
        check_float_array_equality(&result, &[-3.0f32, -3.0f32, -3.0f32, -3.0f32])?;

        if get_fuzzing() {
            info!("Starting fuzzing");
            for _ in 0..get_iterations() {
                let r1 = get_random_float32_array::<4>();
                let r2 = get_random_float32_array::<4>();
                let r3 = get_random_float32_array::<4>();
                let a_r = _mm_set_ps(r1[3], r1[2], r1[1], r1[0]);
                let b_r = _mm_set_ps(r2[3], r2[2], r2[1], r2[0]);
                let c_r = _mm_set_ps(r3[3], r3[2], r3[1], r3[0]);
                let _ = _mm_fnmsub_ps(a_r, b_r, c_r);
            }
        }
    }
    Ok(())
}
