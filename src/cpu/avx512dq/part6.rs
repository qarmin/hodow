use std::arch::x86_64::*;

use log::info;

use crate::cpu::common::{check_array_equality, check_float_array_equality, get_random_float32_array, get_random_float64_array, get_random_i32_array};
use crate::cpu::get_iterations;
use crate::get_fuzzing;

pub(super) fn test_mm_maskz_range_round_ss() -> Result<(), String> {
    unsafe {
        let x = _mm_set_ss(3.25);
        let s = _mm_cvtss_f32(x);
        crate::cpu::common::check_float_equality(s, 3.25f32)?;
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

pub(super) fn test_mm_mask_range_ss() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(1.0, 2.0, 3.0, 4.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_float_array_equality(&out, &[4.0, 3.0, 2.0, 1.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ps(
                    get_random_float32_array::<4>()[0],
                    get_random_float32_array::<4>()[1],
                    get_random_float32_array::<4>()[2],
                    get_random_float32_array::<4>()[3],
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_range_ss() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(5.0, 6.0, 7.0, 8.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_float_array_equality(&out, &[8.0, 7.0, 6.0, 5.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ps(
                    get_random_float32_array::<4>()[0],
                    get_random_float32_array::<4>()[1],
                    get_random_float32_array::<4>()[2],
                    get_random_float32_array::<4>()[3],
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(2.0, 3.0);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(a);
        check_float_array_equality(&out, &[3.0, 2.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(9.0, 8.0);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(a);
        check_float_array_equality(&out, &[8.0, 9.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_reduce_pd() -> Result<(), String> {
    unsafe {
        let a = _mm_set_pd(11.0, 10.0);
        let out: [f64; 2] = std::mem::transmute::<__m128d, [f64; 2]>(a);
        check_float_array_equality(&out, &[10.0, 11.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_pd(get_random_float64_array::<2>()[0], get_random_float64_array::<2>()[1]);
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_ps() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(2.0, 4.0, 6.0, 8.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_float_array_equality(&out, &[8.0, 6.0, 4.0, 2.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ps(
                    get_random_float32_array::<4>()[0],
                    get_random_float32_array::<4>()[1],
                    get_random_float32_array::<4>()[2],
                    get_random_float32_array::<4>()[3],
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_mask_reduce_ps() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(1.0, 3.0, 5.0, 7.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_float_array_equality(&out, &[7.0, 5.0, 3.0, 1.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ps(
                    get_random_float32_array::<4>()[0],
                    get_random_float32_array::<4>()[1],
                    get_random_float32_array::<4>()[2],
                    get_random_float32_array::<4>()[3],
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_maskz_reduce_ps() -> Result<(), String> {
    unsafe {
        let v = _mm_set_ps(13.0, 14.0, 15.0, 16.0);
        let out: [f32; 4] = std::mem::transmute::<__m128, [f32; 4]>(v);
        check_float_array_equality(&out, &[16.0, 15.0, 14.0, 13.0])?;
    }
    if get_fuzzing() {
        info!("Starting fuzzing");
        for _ in 0..get_iterations() {
            unsafe {
                let _ = _mm_set_ps(
                    get_random_float32_array::<4>()[0],
                    get_random_float32_array::<4>()[1],
                    get_random_float32_array::<4>()[2],
                    get_random_float32_array::<4>()[3],
                );
            }
        }
    }
    Ok(())
}

pub(super) fn test_mm_reduce_round_sd() -> Result<(), String> {
    unsafe {
        let x = _mm_set_sd(2.5);
        let s = _mm_cvtsd_f64(x);
        crate::cpu::common::check_float_equality(s as f32, 2.5f32)?;
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

pub(super) fn test_mm_mask_reduce_round_sd() -> Result<(), String> {
    unsafe {
        let x = _mm_set_sd(6.5);
        let s = _mm_cvtsd_f64(x);
        crate::cpu::common::check_float_equality(s as f32, 6.5f32)?;
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

pub(super) fn test_mm_maskz_reduce_round_sd() -> Result<(), String> {
    unsafe {
        let x = _mm_set_sd(4.25);
        let s = _mm_cvtsd_f64(x);
        crate::cpu::common::check_float_equality(s as f32, 4.25f32)?;
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

pub(super) fn test_mm_reduce_sd() -> Result<(), String> {
    unsafe {
        let x = _mm_set_sd(11.0);
        let s = _mm_cvtsd_f64(x);
        crate::cpu::common::check_float_equality(s as f32, 11.0f32)?;
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

pub(super) fn test_mm_mask_reduce_sd() -> Result<(), String> {
    unsafe {
        let x = _mm_set_sd(12.0);
        let s = _mm_cvtsd_f64(x);
        crate::cpu::common::check_float_equality(s as f32, 12.0f32)?;
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

pub(super) fn test_mm_maskz_reduce_sd() -> Result<(), String> {
    unsafe {
        let x = _mm_set_sd(13.0);
        let s = _mm_cvtsd_f64(x);
        crate::cpu::common::check_float_equality(s as f32, 13.0f32)?;
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
