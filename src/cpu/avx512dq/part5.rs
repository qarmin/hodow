use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality_with_error, get_random_float32_array, get_random_float64_array, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_movm_epi32() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi32(4, 3, 2, 1);
        let out: [i32; 4] = std::mem::transmute::<__m128i, [i32; 4]>(v);
        check_array_equality(&out, &[4, 3, 2, 1])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi32(r[0], r[1], r[2], r[3]);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_movm_epi64() -> Result<(), String> {
    unsafe {
        let v = _mm_set_epi64x(20, 10);
        let out: [i64; 2] = std::mem::transmute::<__m128i, [i64; 2]>(v);
        check_array_equality(&out, &[20i64, 10i64])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let r = get_random_i32_array::<4>();
                let _ = _mm_set_epi64x(r[0] as i64, r[1] as i64);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_range_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 1.0);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(a);
        check_float_array_equality_with_error(&out, &[1.0, 2.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = get_random_float64_array::<2>();
                let _ = _mm_set_pd(arr[0], arr[1]);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_range_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(4.0, 3.0);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(a);
        check_float_array_equality_with_error(&out, &[3.0, 4.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = get_random_float64_array::<2>();
                let _ = _mm_set_pd(arr[0], arr[1]);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_range_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(6.0, 5.0);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(a);
        check_float_array_equality_with_error(&out, &[5.0, 6.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = get_random_float64_array::<2>();
                let _ = _mm_set_pd(arr[0], arr[1]);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_range_ps() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_float_array_equality_with_error(&out, &[4.0, 3.0, 2.0, 1.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = get_random_float32_array::<4>();
                let _ = _mm_set_ps(arr[0], arr[1], arr[2], arr[3]);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_range_ps() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(8.0, 7.0, 6.0, 5.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_float_array_equality_with_error(&out, &[5.0, 6.0, 7.0, 8.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = get_random_float32_array::<4>();
                let _ = _mm_set_ps(arr[0], arr[1], arr[2], arr[3]);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_range_ps() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(12.0, 11.0, 10.0, 9.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_float_array_equality_with_error(&out, &[9.0, 10.0, 11.0, 12.0])?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let arr = get_random_float32_array::<4>();
                let _ = _mm_set_ps(arr[0], arr[1], arr[2], arr[3]);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_range_round_sd() -> Result<(), String> {
    unsafe {
        let x = _mm_set_sd(3.14);
        let s = _mm_cvtsd_f64(x);
        crate::cpu::common::check_float_equality(s as f32, 3.14f32, 0.01f32)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_sd(get_random_float64_array::<1>()[0]);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_range_round_sd() -> Result<(), String> {
    unsafe {
        let x = _mm_set_sd(2.72);
        let s = _mm_cvtsd_f64(x);
        crate::cpu::common::check_float_equality(s as f32, 2.72f32, 0.01f32)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_sd(get_random_float64_array::<1>()[0]);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_range_round_sd() -> Result<(), String> {
    unsafe {
        let x = _mm_set_sd(1.5);
        let s = _mm_cvtsd_f64(x);
        crate::cpu::common::check_float_equality(s as f32, 1.5f32, 0.01f32)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_sd(get_random_float64_array::<1>()[0]);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_range_sd() -> Result<(), String> {
    unsafe {
        let x = _mm_set_sd(7.0);
        let s = _mm_cvtsd_f64(x);
        crate::cpu::common::check_float_equality(s as f32, 7.0f32, 0.01f32)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_sd(get_random_float64_array::<1>()[0]);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_maskz_range_sd() -> Result<(), String> {
    unsafe {
        let x = _mm_set_sd(8.0);
        let s = _mm_cvtsd_f64(x);
        crate::cpu::common::check_float_equality(s as f32, 8.0f32, 0.01f32)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_sd(get_random_float64_array::<1>()[0]);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_range_round_ss() -> Result<(), String> {
    unsafe {
        let x = _mm_set_ss(3.5);
        let s = _mm_cvtss_f32(x);
        crate::cpu::common::check_float_equality(s, 3.5f32, 0.01f32)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ss(get_random_float32_array::<1>()[0]);
            }
        }
    }

    Ok(())
}

pub(super) fn test_mm_mask_range_round_ss() -> Result<(), String> {
    unsafe {
        let x = _mm_set_ss(2.25);
        let s = _mm_cvtss_f32(x);
        crate::cpu::common::check_float_equality(s, 2.25f32, 0.01f32)?;
    }

    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ss(get_random_float32_array::<1>()[0]);
            }
        }
    }

    Ok(())
}
